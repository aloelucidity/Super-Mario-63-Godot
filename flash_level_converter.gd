extends Node

@onready var tiles = $Tiles

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	tiles.clear()
	
	var level_resource: Resource = load("res://test_codes/dragon_valley.tres")
	var level_code: String = level_resource.get_meta("level_code", "")
	
	var level_array: Array = convert_flash_level(level_code)
	
	var x: int = 0
	var y: int = 0
	var grid_y_size: int = level_array[1]
	for tile in level_array[5]:
		var tile_id: int = tile[0]
		var id_to_coords := Vector2i(
			tile_id % 16,
			tile_id >> 4)
		
		for _repeat in range(tile[1]):
			tiles.set_cell(Vector2i(x, y), 1, id_to_coords)
			
			y += 1
			if y >= grid_y_size:
				y = 0
				x += 1


func convert_flash_level(level_code: String) -> Array:
	var grid_x_size: int = 50
	var grid_y_size: int = 30
	
	var code: PackedStringArray = level_code.split("~")
	grid_x_size = int(code[0].split("x")[0])
	grid_y_size = int(code[0].split("x")[1])
	
	var ld_music := int(code[3])
	var ld_course_bg := int(code[4])
	var ld_course_name := code[5].uri_decode()
	
	var tile_array: Array = expand_numbers(code[1])
	
	var ld_item_array: Array = code[2].split("|")
	for i in range(ld_item_array.size()):
		ld_item_array[i] = ld_item_array[i].split(",")
	
	return [grid_x_size, grid_y_size, ld_music, ld_course_bg, ld_course_name, tile_array, ld_item_array]


## TODO: comment this
func expand_numbers(code: String) -> Array: 
	var array: Array
	
	var found_tile: String = ""
	var i: int = 0
	
	while i < code.length():
		var tile_0: String = code[i]
		var tile_1: String = ""
		if tile_0 != "0":
			tile_1 = code[i+1]
		
		found_tile = tile_0 + tile_1
		if tile_1 != "": i += 1
		
		i += 1
		
		var multiplier: int = 1
		if code[i] == "*":
			var next_asterisk = code.find("*", i+1)
			var mult_string: String = code.substr(i+1, next_asterisk - i - 1)
			
			multiplier = int(mult_string)
			i = next_asterisk + 1
		
		array.append([ascii_to_tile(found_tile), multiplier])
	return array


func ascii_to_tile(ascii: String) -> int:
	if ascii == "0": return 0
	
	var digit_0 = (ascii.unicode_at(0) - 49) * 75
	var digit_1 = ascii.unicode_at(1) - 49
	return digit_0 + digit_1
