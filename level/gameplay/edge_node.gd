class_name EdgeNode
extends VisibleOnScreenNotifier2D


@export var edge: RoomEdge
@export var camera: CharacterCamera


func _init(_edge: RoomEdge, _camera: CharacterCamera) -> void:
	edge = _edge
	camera = _camera


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
