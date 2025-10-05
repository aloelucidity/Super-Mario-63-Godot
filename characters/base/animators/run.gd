class_name RunAnimator
extends Animator


const MAX_FRAME: int = 79 # 1 lower cuz of zero indexing
@onready var character: Character = get_owner()
@export var footstep_player: StepPlayer

var air_count: float = 1
var last_compare: int


func _update() -> void:
	movie_clip.speed_scale = 0
	
	if character.on_ground:
		movie_clip.frame += roundi( abs(character.velocity.x * 0.9) )
		air_count = 1
	else:
		movie_clip.frame += roundi( abs(character.velocity.x * 1.2) / air_count )
		air_count += 0.2
	
	if movie_clip.frame >= MAX_FRAME:
		movie_clip.frame = 0
	if movie_clip.frame < 0:
		movie_clip.frame = MAX_FRAME
	
	# when his feet are on the ground
	var compare_frame: int = floori(float(movie_clip.frame) / 10)
	if compare_frame != last_compare and compare_frame % 4 == 1:
		footstep_player.play_step()
	last_compare = compare_frame
	
	#movie_clip.frame +=  * character.facing_dir
