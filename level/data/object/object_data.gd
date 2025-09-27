class_name ObjectData
extends SerializedResource


## Should be the same as the dictionary key. Placed here for easy referencing.
var object_key: int
## Passed into the ID map when encoding level codes
var object_path: String
## Tells the game which unique properties to include, and which base properties to exclude.
var property_map: PropertyMap

## Includes both base and unique properties.
var properties: Dictionary[StringName, Variant]


## This takes the value of blacklisted_base_properties into account.
func init_properties() -> Dictionary[StringName, Variant]:
	var base_dictionary: Dictionary[StringName, Variant] = {
		"position": Vector2i.ZERO,
		"rotation": 0.0,
		"skew": 0.0,
		"scale": Vector2.ONE,
		"visible": true,
		"tangible": true,
		"functional": true
	}
	
	for blacklisted_property: String in property_map.blacklisted_base_properties:
		base_dictionary.erase(blacklisted_property)
	for unique_property: String in property_map.unique_properties.keys():
		base_dictionary.set(unique_property, property_map.unique_properties[unique_property])
	
	return base_dictionary


func _init(_object_key: int, _object_path: String, _property_map: PropertyMap) -> void:
	object_key = _object_key
	object_path = _object_path
	property_map = _property_map
	properties = init_properties()
