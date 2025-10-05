class_name WalkAnimator
extends Animator


const MAX_FRAME: int = 79 # 1 lower cuz of zero indexing
@onready var character: Character = get_owner()
@export var footstep_player: StepPlayer

var last_compare: int


func _update() -> void:
	movie_clip.speed_scale = 0
	movie_clip.frame += int(character.velocity.x)
	
	if movie_clip.frame >= MAX_FRAME:
		movie_clip.frame = 0
	if movie_clip.frame < 0:
		movie_clip.frame = MAX_FRAME
	
	# when his feet are on the ground
	var compare_frame: int = floori(float(movie_clip.frame) / 10)
	if compare_frame != last_compare and compare_frame % 4 == 1:
		footstep_player.play_step()
	last_compare = compare_frame
