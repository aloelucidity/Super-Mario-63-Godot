class_name MovieClip
extends Node2D


var animation_player: AnimationPlayer


func _enter_tree() -> void:
	animation_player = $AnimationPlayer


func _update() -> void:
	pass


func get_current_animation() -> String:
	return animation_player.current_animation


func is_playing() -> bool:
	return animation_player.is_playing()


func stop(keep_state: bool = false) -> void:
	animation_player.stop(keep_state)


func play(animation_name: StringName = &"", custom_blend: float = -1, custom_speed: float = 1.0, from_end: bool = false) -> void:
	animation_player.play(animation_name, custom_blend, custom_speed, from_end)


func advance(delta: float = 0) -> void:
	animation_player.advance(delta)
