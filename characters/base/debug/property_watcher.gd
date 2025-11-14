extends Label

@export var object_to_watch: Node
@export var property_to_watch: String

func _process(_delta: float) -> void:
	text = str(object_to_watch[property_to_watch])
