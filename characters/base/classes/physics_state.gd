@abstract
class_name PhysicsState
extends CharacterState


@export_group("Collision")
## this is basically just another kind of friction that gets applied every time
## the character clips into the floor before they're pushed out. 
## dunno why this was a thing but, shrug
@export var ground_resolve_mult: float = 0.98 
