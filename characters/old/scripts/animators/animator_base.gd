class_name AnimatorBase
extends Node


@export var animation_player: AnimationPlayer


var frame: int :
	set (value):
		animation_player.seek(MathFuncs.frame_to_seconds(value))
	get:
		return MathFuncs.seconds_to_frame(animation_player.current_animation_position)
