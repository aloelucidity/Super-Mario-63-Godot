extends Node


const PROPERTY_IDS: IDMap = preload("res://level/objects/object_ids.tres")
const PROPERTY_MAP_PATH: String = "res://level/objects/%s/property_map.tres"

const TILE_LAYER_OVERRIDES: TileLayerOverrides = preload("res://level/compatibility/tiles/layer_overrides.tres")
const CONVERSION_MAP_PATH: String = "res://level/objects/%s/conversion_map.tres"


func _ready() -> void:
	var level_resource: Resource = load("res://test_codes/dragon_valley.tres")
	var level_code: String = level_resource.get_meta("level_code", "")
	var converted_level: Level = convert_legacy_level(level_code)
	
	var level_loader := LevelLoader.new(converted_level)
	level_loader.load_level()
	SceneManager.play_loaded_level(level_loader)
	queue_free()


func convert_legacy_level(level_code: String) -> Level:
	var level := Level.new()
	var room := Room.new()
	
	var back_layer := Layer.new()
	var front_layer := Layer.new()
	var very_front_layer := Layer.new() # lol, this is just for arrows
	back_layer.objects_over_terrain = true
	
	var code: PackedStringArray = level_code.split("~")
	var grid_x_size: int = int(code[0].split("x")[0])
	var grid_y_size: int = int(code[0].split("x")[1])
	
	#var ld_music := int(code[3])
	#var ld_course_bg := int(code[4])
	#var ld_course_name := code[5].uri_decode()
	
	var tile_layers: Array[Dictionary] = decode_legacy_tiles(code[1], Vector2i(grid_x_size, grid_y_size))
	back_layer.tiles = tile_layers[0]
	front_layer.tiles = tile_layers[1]
	
	# Split items into their own array
	var split_item_array: PackedStringArray = code[2].split("|")
	var ld_item_array: Array[PackedStringArray]
	for i in range(split_item_array.size()):
		ld_item_array.append(split_item_array[i].split(","))
	
	# Find start position and create spawn info class
	var start_pos_index: int = ld_item_array.find_custom(is_start_position.bind())
	if start_pos_index > -1:
		var start_pos: Array = ld_item_array[start_pos_index]
		ld_item_array.remove_at(start_pos_index)
		
		var spawn_info := CharacterSpawnInfo.new(
			Vector2(float(start_pos[1]), float(start_pos[2])), # spawn position
			Vector2(float(start_pos[3]), float(start_pos[4])), # spawn velocity
			1 if start_pos[4] == "Right" else -1 # spawn direction
		)
		room.spawn_info = spawn_info
	else:
		room.spawn_info = CharacterSpawnInfo.new()
	
	# Decode the rest of the objects
	var object_layers: Array[Dictionary] = decode_legacy_objects(ld_item_array)
	back_layer.objects = object_layers[0]
	front_layer.objects = object_layers[1]
	very_front_layer.objects = object_layers[2]
	
	# Finalize
	room.layers.append(back_layer)
	room.layers.append(front_layer)
	room.layers.append(very_front_layer)
	room.base_layer_index = 1
	level.rooms["Room 1"] = room
	return level


func decode_legacy_objects(ld_item_array: Array[PackedStringArray]) -> Array[Dictionary]:
	var back_dictionary: Dictionary[int, ObjectData]
	var front_dictionary: Dictionary[int, ObjectData]
	var very_front_dictionary: Dictionary[int, ObjectData]
	
	for key: int in range(ld_item_array.size()):
		var ld_item: PackedStringArray = ld_item_array[key]
		
		## Get basic variables required for ObjectData
		var object_path: String = PROPERTY_IDS.ids[int(ld_item[0])]
		var property_map: PropertyMap
		
		## Find and load property map file
		var folder_path: String = object_path.split("/")[0]
		if FileAccess.file_exists(PROPERTY_MAP_PATH % object_path):
			property_map = load(PROPERTY_MAP_PATH % object_path)
		elif FileAccess.file_exists(PROPERTY_MAP_PATH % folder_path):
			property_map = load(PROPERTY_MAP_PATH % folder_path)
		else:
			## Property map doesn't exist, use an empty one
			property_map = PropertyMap.new()
		
		## Create object data
		var object_data := ObjectData.new(key, object_path, property_map)
		
		## Set position from the second and third values, which
		## are universally X and Y across every object in SM63
		var item_position := Vector2i(int(ld_item[1]), int(ld_item[2]))
		object_data.properties.set("position", item_position)
		
		## Find and load conversion map file
		var conversion_map: ConversionMap
		if FileAccess.file_exists(CONVERSION_MAP_PATH % object_path):
			conversion_map = load(CONVERSION_MAP_PATH % object_path)
		elif FileAccess.file_exists(CONVERSION_MAP_PATH % folder_path):
			conversion_map = load(CONVERSION_MAP_PATH % folder_path)
		else:
			## Conversion map doesn't exist, use an empty one
			conversion_map = ConversionMap.new()
		
		## Set properties from conversion map variables
		for i: int in range(conversion_map.converted_properties.size()):
			var property_name: String = conversion_map.converted_properties[i]
			var property_type: int = conversion_map.converted_types[i]
			var property_value: Variant = string_to_value(ld_item[3 + i], property_type)
			
			if property_name == "rotation":
				property_value = deg_to_rad(float(property_value))
			
			if property_name == "mirrored":
				property_name = "scale"
				property_value = Vector2(-1 if property_value else 1, 1)
			
			object_data.properties.set(property_name, property_value)
		
		## Done converting object, put it in the dictionary
		if conversion_map.is_very_foreground:
			very_front_dictionary[key] = object_data
		elif conversion_map.is_foreground:
			front_dictionary[key] = object_data
		else:
			back_dictionary[key] = object_data
	return [back_dictionary, front_dictionary, very_front_dictionary]


func decode_legacy_tiles(code: String, level_bounds: Vector2i) -> Array[Dictionary]: 
	# Our new level system wants these formatted as a dictionary with the tile positions being keys
	var back_dictionary: Dictionary[Vector2i, int]
	var front_dictionary: Dictionary[Vector2i, int]
	
	# Initialize some variables to be used later
	var found_tile: String = ""
	var i: int = 0
	var x: int = 0
	var y: int = 0
	
	while i < code.length():
		# Air doesn't need an extra digit
		var digit_0: String = code[i]
		var digit_1: String = ""
		if digit_0 != "0":
			digit_1 = code[i+1]
		
		# These are still strings, so this meshes them together rather than combining their value
		# Skip past one index if the tile is air, otherwise two
		found_tile = digit_0 + digit_1
		if digit_1 != "": i += 1
		
		i += 1
		
		# Simple run length encoding, if a tile has an asterisk after it
		# it will take the number afterwards (which is terminated by another asterisk)
		# and treat it as if the tile was repeated N amount of times
		var multiplier: int = 1
		if code[i] == "*":
			var next_asterisk: int = code.find("*", i+1)
			var mult_string: String = code.substr(i+1, next_asterisk - i - 1)
			
			multiplier = int(mult_string)
			i = next_asterisk + 1
		
		# Time to take the weird string and turn it into an actual tile number
		# As well as put it at its proper X/Y position...
		for repeat in range(multiplier):
			var grid_pos := Vector2i(x, y)
			var tile_id: int = ascii_to_tile(found_tile)
			
			if not tile_id in TILE_LAYER_OVERRIDES.overrides:
				front_dictionary[grid_pos] = tile_id
			else:
				var tile_list: Vector2i = TILE_LAYER_OVERRIDES.overrides[tile_id]
				back_dictionary[grid_pos] = tile_list.x
				front_dictionary[grid_pos] = tile_list.y
			
			y += 1
			if y >= level_bounds.y:
				y = 0
				x += 1
	
	return [back_dictionary, front_dictionary]


func ascii_to_tile(ascii: String) -> int:
	if ascii == "0": return 0
	var digit_0: int = (ascii.unicode_at(0) - 49) * 75
	var digit_1: int = ascii.unicode_at(1) - 49
	return digit_0 + digit_1


func is_start_position(object_array: Array) -> bool:
	return object_array[0] == "1"


func string_to_value(string: String, type: int) -> Variant:
	match type:
		TypeMap.Type.Bool:
			return true if string == "True" else false
		TypeMap.Type.Int:
			return int(string)
		TypeMap.Type.Float:
			return float(string)
		TypeMap.Type.String:
			return string.uri_decode()
	return null
