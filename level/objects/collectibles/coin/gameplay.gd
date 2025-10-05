class_name Coin
extends GameplayObject


const SOUND_COOLDOWN: int = 4

@onready var movie_clip: MovieClip = $MovieClip
@onready var delete_timer: Timer = $DeleteTimer
@onready var sound: AudioStreamPlayer = $Sound
var is_collected: bool


func _ready() -> void:
	movie_clip.play("spin")


func collected(hit_area: CollectorArea) -> void:
	if is_collected: return
	is_collected = true
	
	if level_loader.coin_cooldown <= 0:
		level_loader.coin_cooldown = SOUND_COOLDOWN
		sound.play()
	
	hit_area.collect(self)
	movie_clip.play("collect")
	delete_timer.start()
