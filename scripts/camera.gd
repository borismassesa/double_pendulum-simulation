extends Camera3D

# Camera control properties
var camera_speed: float = 0.1      # Speed of camera movement
var zoom_speed: float = 0.1        # Speed of zoom
var rotation_speed: float = 0.01   # Speed of rotation

# Camera state variables
var dragging: bool = false         # Is the right mouse button being held?
var last_mouse_pos: Vector2        # Last recorded mouse position

# Called when the node enters the scene tree
func _ready():
	# Set initial camera position and orientation
	position = Vector3(0, 2, 10)   # Place camera above and behind the pendulum
	look_at(Vector3.ZERO)          # Look at the center point

# Handle input events for camera control
func _unhandled_input(event):
	# Handle mouse button events
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_RIGHT:
			# Right mouse button controls rotation
			dragging = event.pressed
			last_mouse_pos = event.position
		elif event.button_index == MOUSE_BUTTON_WHEEL_UP:
			# Mouse wheel up zooms in
			position += transform.basis.z * zoom_speed
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			# Mouse wheel down zooms out
			position -= transform.basis.z * zoom_speed
			
	# Handle mouse motion for camera rotation
	elif event is InputEventMouseMotion and dragging:
		var delta = event.position - last_mouse_pos
		rotation.y -= delta.x * rotation_speed  # Rotate around Y axis
		rotation.x -= delta.y * rotation_speed  # Rotate around X axis
		rotation.x = clamp(rotation.x, -PI/2, PI/2)  # Limit vertical rotation
		last_mouse_pos = event.position
