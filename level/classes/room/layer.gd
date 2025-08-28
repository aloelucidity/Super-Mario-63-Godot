class_name Layer
extends SerializedResource

## Z index is automatically handled by layer order, no manual z-indexing required.

var objects: Dictionary[int, ObjectData] ## ID, ObjectData
var tint: Color
var scale: Vector2
var parallax: Vector2

## Has no effect if mission_id is empty. If mission_id is something specific, then
## the layer becomes a "mission layer" and will have the same Z index as the layer below it.
## If the current mission doesn't match up with the layer's mission_id, 
## the layer won't load in at all.
var mission_id: String 
