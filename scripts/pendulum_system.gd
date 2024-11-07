extends Node3D

# Configuration parameters
@export_group("Pendulum Properties")
@export var rod_length_1: float = 1.0
@export var rod_length_2: float = 1.0
@export var mass_1: float = 1.0
@export var mass_2: float = 1.0
@export var gravity: float = 9.81
@export var damping: float = 0.999

@export_group("Initial Conditions")
@export var initial_angle_1: float = PI / 4  # 45 degrees
@export var initial_angle_2: float = PI / 4
@export var initial_velocity_1: float = 0.0
@export var initial_velocity_2: float = 0.0

@export_group("Debug")
@export var debug_mode: bool = true
@export var pause_simulation: bool = false

# State variables
var theta1: float      # Angle of first pendulum
var theta2: float      # Angle of second pendulum
var omega1: float      # Angular velocity of first pendulum
var omega2: float      # Angular velocity of second pendulum

# Node references
@onready var pivot = $Pivot
@onready var arm1 = $Pivot/Arm1
@onready var arm2 = $Pivot/Arm1/Arm2
@onready var mass1 = $Pivot/Arm1/Mass1
@onready var mass2 = $Pivot/Arm1/Arm2/Mass2

func _ready():
	if debug_mode:
		print("Starting pendulum simulation...")

	# Initialize the pendulum state
	theta1 = initial_angle_1
	theta2 = initial_angle_2
	omega1 = initial_velocity_1
	omega2 = initial_velocity_2

	# Verify node setup
	verify_nodes()

	# Initial position update
	update_positions()

func verify_nodes():
	if debug_mode:
		print("[Pendulum] Verifying nodes...")
		print("[Pendulum] Arm1: ", arm1 != null)
		print("[Pendulum] Arm2: ", arm2 != null)
		print("[Pendulum] Mass1: ", mass1 != null)
		print("[Pendulum] Mass2: ", mass2 != null)

func _physics_process(delta):
	if pause_simulation:
		return

	calculate_physics(delta)
	update_positions()

	if debug_mode:
		print("Physics Frame: ", Engine.get_physics_frames())
		debug_state()

func calculate_physics(delta):
	# Variables for readability
	var g = gravity
	var m1 = mass_1
	var m2 = mass_2
	var l1 = rod_length_1
	var l2 = rod_length_2

	# Precompute common terms
	var sin_t1 = sin(theta1)
	var sin_t2 = sin(theta2)
	var cos_t1 = cos(theta1)
	var cos_t2 = cos(theta2)
	var sin_diff = sin(theta1 - theta2)
	var cos_diff = cos(theta1 - theta2)

	# Calculate denominators first (to avoid division by zero)
	var den1 = l1 * (2.0 * m1 + m2 - m2 * cos(2.0 * (theta1 - theta2)))
	var den2 = l2 * (2.0 * m1 + m2 - m2 * cos(2.0 * (theta1 - theta2)))

	if abs(den1) < 0.000001 or abs(den2) < 0.000001:
		if debug_mode:
			print("[Pendulum] Warning: Denominator too close to zero")
		return

	# Calculate angular acceleration for first pendulum
	var num1 = -g * (2.0 * m1 + m2) * sin_t1
	num1 -= m2 * g * sin(theta1 - 2.0 * theta2)
	num1 -= 2.0 * sin_diff * m2 * (
		pow(omega2, 2) * l2 +
		pow(omega1, 2) * l1 * cos_diff
	)
	var alpha1 = num1 / den1

	# Calculate angular acceleration for second pendulum
	var num2 = 2.0 * sin_diff * (
		pow(omega1, 2) * l1 * (m1 + m2) +
		g * (m1 + m2) * cos_t1 +
		pow(omega2, 2) * l2 * m2 * cos_diff
	)
	var alpha2 = num2 / den2

	# Update angular velocities
	omega1 += alpha1 * delta
	omega2 += alpha2 * delta

	# Apply damping
	omega1 *= damping
	omega2 *= damping

	# Update angles
	theta1 += omega1 * delta
	theta2 += omega2 * delta

func update_positions():
	# Update pivot and arm rotations
	pivot.rotation = Vector3.ZERO  # Reset pivot rotation
	arm1.rotation = Vector3(0, 0, theta1)  # First pendulum angle
	arm2.rotation = Vector3(0, 0, theta2 - theta1)  # Second pendulum angle relative to arm1

func debug_state():
	# Print current state information every few frames
	if Engine.get_physics_frames() % 60 == 0:  # Once per second at 60 fps
		print("[Pendulum] State:")
		print("  Theta1: ", rad_to_deg(theta1), "°")
		print("  Theta2: ", rad_to_deg(theta2), "°")
		print("  Omega1: ", omega1)
		print("  Omega2: ", omega2)

func _input(event):
	# Handle debug input
	if event.is_action_pressed("ui_cancel"):  # Esc key
		pause_simulation = !pause_simulation
		if debug_mode:
			print("[Pendulum] Simulation ", "paused" if pause_simulation else "resumed")

	elif event.is_action_pressed("ui_accept"):  # Enter key
		reset_simulation()

func reset_simulation():
	# Reset to initial conditions
	theta1 = initial_angle_1
	theta2 = initial_angle_2
	omega1 = initial_velocity_1
	omega2 = initial_velocity_2
	update_positions()

	if debug_mode:
		print("[Pendulum] Simulation reset to initial conditions")

# Optional: Add these helper functions if needed
func set_angles(angle1: float, angle2: float):
	theta1 = angle1
	theta2 = angle2
	omega1 = 0.0
	omega2 = 0.0
	update_positions()

func set_rod_lengths(length1: float, length2: float):
	rod_length_1 = length1
	rod_length_2 = length2
	# Note: Visual update of rod lengths should be handled by setup_scene.gd
