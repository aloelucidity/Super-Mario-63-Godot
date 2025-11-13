class_name Character
extends Node2D


### Basics
var input: Dictionary
var velocity: Vector2
var gravity: float
var facing_dir: int = 1 : 
	set(new_value):
		if facing_dir != new_value:
			emit_signal("direction_changed", new_value)
		facing_dir = new_value


### Attributes
@export var gravity_factor: float = 1 ## for levels with lower/higher gravity
## wide/tall but in one variable. 
## X is from middle to edge, Y is from bottom to top
@export var size: Vector2i 
@export var bounce: float ## special variable to control how much you bounce against walls
@export var on_ground: bool
@export var wall_dir: int
@export var on_ice: bool
@export var on_puddle: bool
@export var land_vel: Vector2
@export var wall_vel: Vector2


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


### Signals
signal direction_changed(new_direction: int)


func set_state(type: String, state: CharacterState) -> void:
	var old_state: CharacterState = self[type]
	if is_instance_valid(old_state):
		old_state._on_exit()
	
	self[type] = state
	
	if is_instance_valid(state):
		state._on_enter()


func check_startups(cur_state: CharacterState, container: Node) -> CharacterState:
	var cur_priority: int = int(-INF)
	if is_instance_valid(cur_state): cur_priority = cur_state.priority
	for check_state: Node in container.get_children():
		var char_state: CharacterState
		if check_state is CharacterState:
			char_state = check_state
		elif check_state is StateLink:
			var link: StateLink = check_state
			char_state = link.link_to
		
		if (
			char_state.priority > cur_priority
		) or (
			char_state.priority >= cur_priority and 
			cur_state.allow_priority_override
		):
			if char_state._startup_check():
				return char_state
	return null


func handle_general_updates() -> void:
	if is_instance_valid(physics_states):
		for phys: PhysicsState in physics_states.get_children():
			phys._general_update()
			
			for act: Node in phys.get_children():
				var action_state: ActionState
				if act is ActionState:
					action_state = act
				elif act is StateLink:
					var link: StateLink = act
					action_state = link.link_to
				action_state._general_update()


func update_states(type: String, container: Node) -> void:
	## handle updates, transitions
	var cur_state: CharacterState = self[type]
	if is_instance_valid(cur_state):
		var transition_to: String = cur_state._transition_check()
		if transition_to == cur_state.name:
			cur_state._update()
		elif is_instance_valid(container) and container.has_node(transition_to):
			var found_node: Node = container.get_node(transition_to)
			var new_state: CharacterState
			if found_node is CharacterState:
				new_state = found_node
			elif found_node is StateLink:
				var link: StateLink = found_node
				new_state = link.link_to
			
			set_state(type, new_state)
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
	"spin",
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
