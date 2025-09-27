extends GameplayObject


const DECOR_INFO_PATH: String = "res://level/objects/%s/decor_info.tres"


func _setup_object() -> void:
	var decor_info: DecorInfo
	if FileAccess.file_exists(DECOR_INFO_PATH % object_data.object_path):
		decor_info = load(DECOR_INFO_PATH % object_data.object_path)
	
		var sprite: Sprite2D = $Sprite
		sprite.texture = decor_info.texture
		sprite.offset = decor_info.offset
	else:
		push_warning("No decoration info exists at path ", object_data.object_path, "!")
