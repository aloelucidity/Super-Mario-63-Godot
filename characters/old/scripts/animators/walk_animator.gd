extends AnimatorBase


const MAX_FRAME: int = 79 # 1 lower cuz of zero indexing
@onready var character: Character = get_owner()


func update() -> void:
	frame += int(character.velocity.x)
	
	if frame >= MAX_FRAME:
		frame = 0
	if frame < 0:
		frame = MAX_FRAME
