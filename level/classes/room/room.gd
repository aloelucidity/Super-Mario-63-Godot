class_name Room
extends SerializedResource


var respawn_pos: Vector2
var environment: RoomEnvironment

var layers: Array[Layer]

## kinda unsure ab the id system for this but we'll see 
var edges: Dictionary[int, RoomEdge]

## for compatibility only, use Terrain and Structure objects instead
var tiles: Dictionary[Vector2i, int]
