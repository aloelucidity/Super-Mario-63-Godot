class_name MovingPlatform
extends StaticBody2D

var angle: float # for circular platforms
var last_pos: Vector2
var diff_pos: Vector2
var landed_on: bool


func handle_character(character: Character) -> void:
	character.position += diff_pos
	character.velocity.x = MathFuncs.ground_friction(character.velocity.x, 0.3, 1.1)
	if not landed_on:
		character.velocity.x -= diff_pos.x/2
	landed_on = true

func release_character(character: Character) -> void:
	if landed_on:
		character.velocity += diff_pos
	landed_on = false
