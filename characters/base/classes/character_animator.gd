class_name CharacterAnimator
extends Node2D


@onready var character: Character = get_owner()
@onready var movie_clip: MovieClip = $MovieClip
@onready var rotation_collider: RotationCollider = %RotationCollider


func _update() -> void:
	var new_anim: String
	
	var sprite_offset: Vector2i
	var sprite_rot: float
	var sprite_skew: float
	var sprite_scale := Vector2.ONE
	var disable_auto_rotation: bool
	
	if is_instance_valid(character.action):
		new_anim = character.action.animation
		sprite_offset = character.action.sprite_offset
		sprite_rot = character.action.sprite_rot
		sprite_skew = character.action.sprite_skew
		sprite_scale = character.action.sprite_scale
		if character.action.disable_auto_rotation:
			disable_auto_rotation = true
	
	if is_instance_valid(character.physics):
		if new_anim == "":
			new_anim = character.physics.animation
			sprite_offset = character.physics.sprite_offset
		
		sprite_rot += character.physics.sprite_rot
		sprite_skew += character.physics.sprite_skew
		sprite_scale *= character.physics.sprite_scale
		if character.physics.disable_auto_rotation:
			disable_auto_rotation = true
	
	position = sprite_offset
	rotation = sprite_rot * character.facing_dir
	skew = sprite_skew
	scale = sprite_scale * Vector2(character.facing_dir, 1)
	
	if not disable_auto_rotation:
		var calculated_rotation: float = rotation_collider.update_rotation()
		rotation_degrees += ((calculated_rotation / 2) - rotation_degrees) / 2
	
	if new_anim == "":
		if movie_clip.is_playing(): 
			movie_clip.play("RESET")
	elif movie_clip.get_current_animation() != new_anim:
		movie_clip.play("RESET")
		movie_clip.advance(0)
		movie_clip.play(new_anim)
		movie_clip.advance(0)
	
	movie_clip._update()
