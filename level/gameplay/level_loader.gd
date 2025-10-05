class_name LevelLoader
extends Node2D

## Constants
const GENERATED_TILESET: TileSet = preload("res://level/compatibility/tiles/generated_tileset.tres")
const CHARACTER_SCENE: PackedScene = preload("res://characters/mario/character.tscn")
const OBJECT_SCENE_PATH: String = "res://level/objects/%s/gameplay.tscn"

## Parameters
var level: Level
var is_demo: bool

## Variables
var cur_room: String = "Room 1"

## Globals
var coin_cooldown: int = 0


## Misc functions
func _init(_level: Level, _is_demo: bool = false) -> void:
	level = _level
	is_demo = _is_demo
	name = "%LevelLoader"


## Timers
func _physics_process(_delta: float) -> void:
	if coin_cooldown > 0:
		coin_cooldown -= 1


## Loading
func load_level() -> void:
	load_character(level.rooms[cur_room].spawn_info)
	load_room(level.rooms[cur_room])


func load_room(room: Room) -> void:
	var i: int = 0
	for layer: Layer in room.layers:
		var layer_node := Parallax2D.new()
		layer_node.z_index = i - room.base_layer_index
		add_child(layer_node)
		
		var objects_container := Node2D.new()
		objects_container.name = "%ObjectsContainer"
		layer_node.add_child(objects_container)
		
		for object_key: int in layer.objects.keys():
			var object_data: ObjectData = layer.objects[object_key]
			var object_scene: GameplayObject
			
			var object_path: String = object_data.object_path
			if not FileAccess.file_exists(OBJECT_SCENE_PATH % object_path):
				object_path = object_data.object_path.split("/")[0]
			
			if FileAccess.file_exists(OBJECT_SCENE_PATH % object_path):
				var loaded_scene: PackedScene = load(OBJECT_SCENE_PATH % object_path)
				object_scene = loaded_scene.instantiate()
				object_scene.level_loader = self
				object_scene._load_properties(object_data)
				object_scene._setup_object()
				objects_container.add_child(object_scene)
			else:
				push_warning("Object ", object_data.object_path, " does not currently exist!")
		
		var tilemap: TileMapLayer = TileMapLayer.new()
		tilemap.tile_set = GENERATED_TILESET
		tilemap.position = Vector2(-32, -32) # for some reason this fixes the alignment of the level?
		layer_node.add_child(tilemap)
		
		for tile_pos: Vector2i in layer.tiles.keys():
			var tile_id: int = layer.tiles[tile_pos]
			var id_to_coords := Vector2i(
				tile_id % 16,
				tile_id >> 4)
			tilemap.set_cell(tile_pos, 0, id_to_coords)
		
		if layer.objects_over_terrain:
			objects_container.move_to_front()
		
		i += 1


func load_character(spawn_info: CharacterSpawnInfo) -> void:
	var character: Character = CHARACTER_SCENE.instantiate()
	character.position = spawn_info.spawn_pos
	character.velocity = spawn_info.spawn_velocity
	character.facing_dir = spawn_info.spawn_dir
	add_child(character)
	
	var camera := CharacterCamera.new(character)
	add_child(camera)
