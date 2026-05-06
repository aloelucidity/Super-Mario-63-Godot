class_name CirclePlatformObject
extends GameplayObject


const PLATFORM_SCENE: PackedScene = preload("res://level/objects/platforms/circle_platform/platform.tscn")
const DOT_SCENE: PackedScene = preload("res://level/objects/platforms/path_dot/movie_clip.tscn")

var platform_nodes: Array[CirclePlatform]
var speed: float
var platforms: int
var distance: float
var offset: float
var size: int

var dot_distance: float = 20
var arm_scale: float = 0


func _ready() -> void:
	if dot_distance < 360:
		var dot_angle: float = 0
		while dot_angle < 360:
			var dot_node: MovieClip = DOT_SCENE.instantiate()
			var radians: float = deg_to_rad(dot_angle)
			dot_node.position = Vector2(
				-sin(radians),
				cos(radians)
			) * distance
			dot_node.z_index = 1
			add_child(dot_node)
			dot_angle += dot_distance
	
	if arm_scale > 0:
		pass
		#clip.attachMovie("PL circle arm", "PLarm", clip.getNextHighestDepth(), {_y:Math.cos(_root.offsetToRadians(offset))*distance, _x:-Math.sin(_root.offsetToRadians(offset))*distance, _rotation:offset-180});
	
	for i in range(platforms):
		var platform: CirclePlatform = PLATFORM_SCENE.instantiate()
		platform.size = size as CirclePlatform.PlatformSize
		platform.angle = angle_from_index(i)
		platform.distance = distance
		platform.speed = speed
		
		var radians: float = deg_to_rad(platform.angle)
		platform.position = Vector2(
			-sin(radians),
			cos(radians)
		) * distance
		platform.last_pos = platform.position
		
		platform_nodes.append(platform)
		add_child(platform)


func angle_from_index(index: float) -> float:
	return index * (360 / float(platforms))


func _load_properties(_object_data: ObjectData) -> void:
	super(_object_data)
	speed = object_data.properties.get("speed", 5)
	platforms = object_data.properties.get("platforms", 2)
	distance = object_data.properties.get("distance", 50)
	offset = object_data.properties.get("offset", 0)
	size = object_data.properties.get("size", 2)
