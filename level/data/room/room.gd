class_name Room
extends SerializedResource


var spawn_info: CharacterSpawnInfo
var environment: RoomEnvironment
var layers: Array[Layer]
## layers behind this will render behind the character, and vice versa for layers in front of this
var base_layer_index: int

## kinda unsure ab the id system for this but we'll see 
var edges: Dictionary[int, RoomEdge]
