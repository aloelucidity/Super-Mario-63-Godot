class_name EdgeNode
extends VisibleOnScreenNotifier2D


const GRACE: float = 128
const HORIZONTAL_BUFFER: float = 32

@export var edge: RoomEdge
@export var level_loader: LevelLoader
var area: Area2D


func _init(_edge: RoomEdge, _level_loader: LevelLoader) -> void:
	edge = _edge
	level_loader = _level_loader


func _enter_tree() -> void:
	var collision_shape := CollisionShape2D.new()
	var rectangle_shape := RectangleShape2D.new()
	
	position = edge.point_1
	rect = Rect2(Vector2.ZERO, Vector2(edge.point_2 - edge.point_1))
	match edge.edge_dir:
		RoomEdge.EdgeDir.Up:
			rect.size.y += GRACE
			rectangle_shape.size = rect.size
			collision_shape.position.y -= GRACE/2
		
		RoomEdge.EdgeDir.Down:
			position.y -= GRACE
			rect.size.y += GRACE
			rectangle_shape.size = rect.size
			collision_shape.position.y += GRACE*1.5
		
		RoomEdge.EdgeDir.Left:
			position = edge.point_1
			rect.size.x += GRACE
			rectangle_shape.size = rect.size
			collision_shape.position.x -= GRACE/2
		
		RoomEdge.EdgeDir.Right:
			position.x -= GRACE
			rect.size.x += GRACE
			rectangle_shape.size = rect.size
			collision_shape.position.x += GRACE*1.5
	
	collision_shape.shape = rectangle_shape
	match edge.edge_type:
		RoomEdge.EdgeType.Block:
			var static_body := StaticBody2D.new()
			static_body.collision_mask = 0
			add_child(static_body)
			static_body.add_child(collision_shape)
		RoomEdge.EdgeType.Warp:
			area = Area2D.new()
			area.collision_layer = 0
			area.collision_mask = 8
			add_child(area)
			area.add_child(collision_shape)
		_: # default
			collision_shape.queue_free()


func character_entered(_hit_area: CollectorArea) -> void:
	set_physics_process(false)
	level_loader.change_room(edge.target_room)



func _physics_process(_delta: float) -> void:
	if not is_on_screen(): return
	
	var camera: CharacterCamera = level_loader.char_results[1]
	var cam_size: Vector2 = camera.get_size()
	var last_pos: Vector2 = camera.position
	
	match edge.edge_dir:
		RoomEdge.EdgeDir.Up:
			camera.position.y = max(camera.position.y, edge.point_1.y + cam_size.y/2)
		RoomEdge.EdgeDir.Down:
			camera.position.y = min(camera.position.y, edge.point_1.y - cam_size.y/2)
		RoomEdge.EdgeDir.Left:
			camera.position.x = max(camera.position.x, edge.point_1.x + cam_size.x/2)
		RoomEdge.EdgeDir.Right:
			camera.position.x = min(camera.position.x, edge.point_1.x - cam_size.x/2)
	
	if last_pos.y != camera.position.y:
		camera.camera_velocity.y = 0
		camera.camera_change.y = 0
		if abs(last_pos.y - camera.position.y) > cam_size.y/2: 
			camera.reset_physics_interpolation()
		
	if last_pos.x != camera.position.x:
		camera.camera_velocity.x = 0
		camera.camera_change.x = 0
		if abs(last_pos.x - camera.position.x) > cam_size.x/2:
			camera.reset_physics_interpolation()
	
	if level_loader.trans_cooldown <= 0 and edge.edge_type == RoomEdge.EdgeType.Warp:
		for overlapping_area: Area2D in area.get_overlapping_areas():
			if overlapping_area is CollectorArea:
				var character: Character = overlapping_area.get_parent()
				var passed: bool = false
				match edge.edge_dir:
					RoomEdge.EdgeDir.Up:
						passed = character.position.y < edge.point_1.y
					RoomEdge.EdgeDir.Down:
						passed = character.position.y > edge.point_1.y
					RoomEdge.EdgeDir.Left:
						passed = character.position.x < edge.point_1.x - HORIZONTAL_BUFFER
					RoomEdge.EdgeDir.Right:
						passed = character.position.x > edge.point_1.x + HORIZONTAL_BUFFER
				if passed:
					character_entered(overlapping_area)
