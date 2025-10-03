class_name CollectorArea
extends Area2D


@export var fall_damage_action: FallDamageAction


func update_direction(new_direction: int) -> void:
	position.x = abs(position.x) * -new_direction


func collect(collected_object: GameplayObject) -> void:
	if collected_object is Coin:
		if is_instance_valid(fall_damage_action):
			fall_damage_action.fall_count = 0
