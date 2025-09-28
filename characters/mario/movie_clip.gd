extends MovieClip


const MAX_FRAME: int = 79 # 1 lower cuz of zero indexing
var character: Character

@export var walk_speed_override: bool = true


var frame: int :
	set (value):
		animation_player.seek(MathFuncs.frame_to_seconds(value))
	get:
		return MathFuncs.seconds_to_frame(animation_player.current_animation_position)


func _enter_tree() -> void:
	super()
	character = get_owner()


func _update() -> void:
	animation_player.speed_scale = 1
	if walk_speed_override and get_current_animation() == "walk":
		animation_player.speed_scale = 0
		frame += int(character.velocity.x)
		
		if frame >= MAX_FRAME:
			frame = 0
		if frame < 0:
			frame = MAX_FRAME
