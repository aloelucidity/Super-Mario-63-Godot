class_name EdgeNode
extends VisibleOnScreenNotifier2D


const GRACE: float = 128

@export var edge: RoomEdge
@export var camera: CharacterCamera


func _init(_edge: RoomEdge, _camera: CharacterCamera) -> void:
	edge = _edge
	camera = _camera


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
			var area := Area2D.new()
			area.collision_layer = 0
			area.collision_mask = 8
			add_child(area)
			area.add_child(collision_shape)
			area.area_entered.connect(character_entered)
		_: # default
			collision_shape.queue_free()


func character_entered(_hit_area: CollectorArea) -> void:
	# reload level loader scene but keep the character scene 
	# and simply change the target room var
	print(edge.target_room)


func _physics_process(_delta: float) -> void:
	if not is_on_screen(): return
	
	var last_pos: Vector2 = camera.position
	match edge.edge_dir:
		RoomEdge.EdgeDir.Up:
			var cam_size: Vector2 = camera.get_size()
			camera.position.y = max(camera.position.y, edge.point_1.y + cam_size.y/2)
		RoomEdge.EdgeDir.Down:
			var cam_size: Vector2 = camera.get_size()
			camera.position.y = min(camera.position.y, edge.point_1.y - cam_size.y/2)
		RoomEdge.EdgeDir.Left:
			var cam_size: Vector2 = camera.get_size()
			camera.position.x = max(camera.position.x, edge.point_1.x + cam_size.x/2)
		RoomEdge.EdgeDir.Right:
			var cam_size: Vector2 = camera.get_size()
			camera.position.x = min(camera.position.x, edge.point_1.x - cam_size.x/2)

	if last_pos.y != camera.position.y:
		camera.camera_velocity.y = 0
		camera.camera_change.y = 0
	if last_pos.x != camera.position.x:
		camera.camera_velocity.x = 0
		camera.camera_change.x = 0
