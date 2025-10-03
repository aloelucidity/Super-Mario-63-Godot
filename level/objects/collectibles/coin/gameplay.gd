class_name Coin
extends GameplayObject


@onready var movie_clip: MovieClip = $MovieClip
@onready var delete_timer: Timer = $DeleteTimer
var is_collected: bool


func _ready() -> void:
	movie_clip.play("spin")


func collected(hit_area: CollectorArea) -> void:
	if is_collected: return
	is_collected = true
	
	hit_area.collect(self)
	movie_clip.play("collect")
	delete_timer.start()
