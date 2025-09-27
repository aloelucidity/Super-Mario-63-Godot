extends Node


var loaded_level: LevelLoader


func play_loaded_level(level_loader: LevelLoader) -> void:
	if is_instance_valid(loaded_level):
		loaded_level.call_deferred("queue_free")
	loaded_level = level_loader
	add_child(loaded_level)
