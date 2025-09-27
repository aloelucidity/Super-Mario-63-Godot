class_name GameplayObject
extends Node2D


var object_data: ObjectData
var tangible: bool
var functional: bool


func _load_properties(_object_data: ObjectData) -> void:
	object_data = _object_data
	position = object_data.properties.get("position", Vector2.ZERO)
	rotation = object_data.properties.get("rotation", 0.0)
	skew = object_data.properties.get("skew", 0.0)
	scale = object_data.properties.get("scale", Vector2.ONE)
	visible = object_data.properties.get("visible", true)
	tangible = object_data.properties.get("tangible", true)
	functional = object_data.properties.get("functional", true)


func _setup_object() -> void:
	pass
