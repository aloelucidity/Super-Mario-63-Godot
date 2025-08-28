class_name AnimationManager
extends Node2D


@onready var character: Character = get_owner()
@onready var animation_player: AnimationPlayer = $AnimationPlayer
var cur_anim: String


func update() -> void:
	scale.x = -character.facing_dir
	
	var new_anim: String
	var cur_animator: AnimatorBase
	
	## get animations
	if is_instance_valid(character.physics):
		if character.physics.animation != "":
			new_anim = character.physics.animation
		if is_instance_valid(character.physics.animator):
			cur_animator = character.physics.animator
	
	if is_instance_valid(character.action):
		if character.action.animation != "":
			new_anim = character.action.animation
		if is_instance_valid(character.action.animator):
			cur_animator = character.action.animator
	
	## play animations
	if new_anim != "" and cur_anim != new_anim:
		cur_anim = new_anim
		animation_player.play(&"RESET")
		animation_player.advance(0)
		animation_player.play(new_anim)
	
	if is_instance_valid(cur_animator):
		animation_player.speed_scale = 0
		cur_animator.update()
	else:
		animation_player.speed_scale = 1
