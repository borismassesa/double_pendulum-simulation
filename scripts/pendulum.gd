extends Node3D

@onready var massOne = $"/root/Main/PendulumSystem/Pivot/Arm/Mass1"
# Constants for physics calculations
const GRAVITY: float = 9.8    # Gravity constant
const DAMPING: float = 0.999  # Damping factor to simulate air resistance


# Properties for first pendulum arm
var angle1: float = PI/4           # Initial angle (45 degrees)
var angular_velocity1: float = 0.0 # Starting angular velocity
var length1: float = 2.0          # Length of first arm
var mass1: float = 1.0            # Mass of first bob

# Properties for second pendulum arm
var angle2: float = PI/4           # Initial angle (45 degrees)
var angular_velocity2: float = 0.0 # Starting angular velocity
var length2: float = 2.0          # Length of second arm
var mass2: float = 1.0            # Mass of second bob

# Called when the node enters the scene tree
func _ready():
	# Initial setup
	_update_pendulum_positions()  # Set initial positions
	

# Called every physics frame
func _physics_process(delta):
	_calculate_angles(delta)      # Update angles based on physics
	_update_pendulum_positions()  # Update visual positions
	#print(delta)

# Calculate new angles based on physics
func _calculate_angles(delta: float):
	# Will implement the double pendulum physics formulas here
	# This is where we'll add the mathematical calculations later
	
	var angular_acceleration = -(GRAVITY/length1) * sin(angle1)
	angular_velocity1 = angular_acceleration * delta
	angle1 += angular_velocity1 * delta
	
	pass

# Update the visual positions of the pendulum arms
func _update_pendulum_positions():
	# Will implement the position updates here
	# This will transform our calculated angles into 3D positions
	var x = length1 * sin(angle1)
	var y = -length1 * cos(angle1)
	#massOne.transform.origin = Vector3(x,y,0)
	pass
