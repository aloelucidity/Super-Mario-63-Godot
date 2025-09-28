class_name Character
extends Node2D


### Basics
var input: Dictionary
var velocity: Vector2
var gravity: float
var facing_dir: int = 1


### Attributes
@export var gravity_factor: float = 1 ## for levels with lower/higher gravity
## wide/tall but in one variable. 
## X is from middle to edge, Y is from bottom to top
@export var size: Vector2i 
@export var bounce: float ## special variable to control how much you bounce against walls
@export var on_ground: bool
@export var on_ice: bool
@export var on_puddle: bool


### Nodes
@onready var collider: ColliderBase = %Collider
@onready var animator: CharacterAnimator = %Animator
@onready var physics_states: Node = %PhysicsStates


### States
var physics: PhysicsState
var action: ActionState

# the below is used for coyote time; when the ground state transitions 
# to the air state, it'll set an override for a few frames so you
# can still do ground actions even if you're slightly late
var container_override: PhysicsState
var override_frames: int


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


func handle_general_updates() -> void:
	if is_instance_valid(physics_states):
		for phys: PhysicsState in physics_states.get_children():
			phys._general_update()
			for act: ActionState in phys.get_children():
				act._general_update()


func update_states(type: String, container: Node) -> void:
	## handle updates, transitions
	var cur_state: CharacterState = self[type]
	if is_instance_valid(cur_state):
		var transition_to: String = cur_state._transition_check()
		if transition_to == cur_state.name:
			cur_state._update()
		elif is_instance_valid(container) and container.has_node(transition_to):
			set_state(type, container.get_node(transition_to))
		else:
			set_state(type, null)
	
	## handle startups
	if is_instance_valid(container):
		var startup_state: CharacterState = check_startups(self[type], container)
		if is_instance_valid(startup_state):
			set_state(type, startup_state)


### Logic
func _enter_tree() -> void:
	gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(_delta: float) -> void:
	input = get_input()
	
	handle_general_updates()
	update_states("physics", physics_states)
	
	var container: PhysicsState = physics
	if override_frames > 0:
		override_frames -= 1
		container = container_override
		if override_frames <= 0: container_override = null
	
	update_states("action", container)
	
	collider._update()
	animator._update()


### Physics
func get_gravity_sum() -> float:
	var total_factor: float = gravity * gravity_factor
	if is_instance_valid(physics):
		total_factor *= physics.gravity_factor
	if is_instance_valid(action):
		total_factor *= action.gravity_factor
	return total_factor


### Input
var inputs_list: Array = [
	"up",
	"down",
	"left",
	"right",
	"jump",
	"dive",
	"ground_pound",
	"interact",
	"door_interact",
	"use_fludd",
	"switch_nozzles"
]
func get_input() -> Dictionary[String, Array]:
	var new_input: Dictionary[String, Array] = {}
	
	for action_name: String in inputs_list:
		var pressed: bool = Input.is_action_pressed(action_name)
		var just_pressed: bool = Input.is_action_just_pressed(action_name)
		new_input[action_name] = [pressed, just_pressed]
	
	return new_input
