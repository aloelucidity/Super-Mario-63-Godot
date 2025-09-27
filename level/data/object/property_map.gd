class_name PropertyMap
extends Resource


## Any properties that are unique to an object should go here.
@export var unique_properties: Dictionary[StringName, Variant] = {
	## speed.. etc
}

## Put any base properties you don't want affecting your object here. Any properties
## that are blacklisted won't be loaded, even if the level code is manually edited.
@export var blacklisted_base_properties: Array[StringName] = [
	## scale... etc
]
