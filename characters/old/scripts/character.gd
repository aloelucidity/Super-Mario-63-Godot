class_name CharacterOld
extends Node2D


@onready var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")

@export var gravity_factor: float = 1
@export var facing_dir: int = 1
@export var velocity: Vector2
@export var physics: CharacterState
@export var action: CharacterState
var gravity_sum: float

@export_group("Nodes")
@export var physics_container: Node
@export var counters_container: Node
@export var collision: CharacterCollision
@export var animations: AnimationManager


func _physics_process(_delta: float) -> void:
	for counter: CharacterCounter in counters_container.get_children():
		counter._update()
	update_states("physics", physics_container)
	update_states("action", physics)
	collision.update()
	animations.update()


func get_gravity_sum() -> float:
	var total_factor: float = gravity * gravity_factor
	if is_instance_valid(physics):
		total_factor *= physics.gravity_factor
	if is_instance_valid(action):
		total_factor *= action.gravity_factor
	return total_factor


func key_pressed(key: String) -> bool:
	return Input.is_action_pressed(key)


### States
func set_state(type: String, state: CharacterState) -> void:
	var old_state: CharacterState = self[type]
	if is_instance_valid(old_state):
		old_state._on_exit()
	
	self[type] = state
	
	if is_instance_valid(state):
		state._on_enter()


func check_startups(cur_state: CharacterState, container: Node) -> CharacterState:
	var cur_priority: int = -1
	if is_instance_valid(cur_state): cur_priority = cur_state.priority
	for check_state: CharacterState in container.get_children():
		if check_state.priority > cur_priority:
			if check_state._startup_check():
				return check_state
	return null


func update_states(type: String, container: Node) -> void:
	## handle startups
	if is_instance_valid(container):
		@warning_ignore("unsafe_call_argument")
		var startup_state: CharacterState = check_startups(self[type], container)
		if is_instance_valid(startup_state):
			set_state(type, startup_state)
	
	## handle updates, transitions
	var cur_state: CharacterState = self[type]
	if is_instance_valid(cur_state):
		var transition_to: String = cur_state._transition_check()
		if transition_to == cur_state.name:
			cur_state._update()
		elif is_instance_valid(container) and container.has_node(transition_to):
			@warning_ignore("unsafe_call_argument")
			set_state(type, container.get_node(transition_to))
		else:
			set_state(type, null)


## temp flags to be relocated
var squish: bool = false # self explanatory
var invisible: bool = false # vanish cap i think
var attack: bool = false # spinning, diving, other stuff
var attack_frame: String # something state related, might not get used here
