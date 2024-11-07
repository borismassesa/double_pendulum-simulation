extends Node3D

@export var debug_mode: bool = true

# Node references
@onready var pendulum_system = $PendulumSystem
@onready var pivot = $PendulumSystem/Pivot
@onready var arm1 = $PendulumSystem/Pivot/Arm1
@onready var arm2 = $PendulumSystem/Pivot/Arm1/Arm2

# Rod lengths from pendulum_system.gd
var rod_length_1: float
var rod_length_2: float

func _ready():
	if debug_mode:
		print("Starting pendulum setup...")
	
	# Get rod lengths from pendulum_system
	rod_length_1 = pendulum_system.rod_length_1
	rod_length_2 = pendulum_system.rod_length_2
	
	create_pendulum()
	create_support()  # Call the function to create the support

func create_pendulum():
	# Create the rods (cylinders)
	create_rod(arm1, rod_length_1)
	create_rod(arm2, rod_length_2)
	
	# Create the masses (spheres) with proper names
	create_mass(arm1, rod_length_1, "Mass1")
	create_mass(arm2, rod_length_2, "Mass2")
	
	# Set up initial positions
	arm1.position = Vector3.ZERO
	arm2.position = Vector3(0, -rod_length_1, 0)  # Position at end of first rod
	
	# Move system up for visibility
	pendulum_system.position.y = 3

func create_support():
	# Create a MeshInstance3D for the support
	var support = MeshInstance3D.new()
	support.name = "Support"
	pivot.add_child(support)
	support.owner = get_tree().edited_scene_root  # Ensure it appears in the scene tree

	# Create a BoxMesh for the support
	var box_mesh = BoxMesh.new()
	box_mesh.size = Vector3(5.0, 0.5, 0.6)  # Increased Width, Height, Depth
	support.mesh = box_mesh

	# Set up material
	var material = StandardMaterial3D.new()
	material.albedo_color = Color(0.6, 0.4, 0.2)  # Brown color
	box_mesh.material = material

	# Position the support
	support.position = Vector3(0, box_mesh.size.y / 2, 0)  # Adjust position based on new height

func create_rod(rod_node: Node3D, rod_length: float):
	# Create a child MeshInstance3D for the rod mesh
	var rod_mesh_instance = MeshInstance3D.new()
	rod_node.add_child(rod_mesh_instance)
	rod_mesh_instance.name = "RodMesh"

	var cylinder = CylinderMesh.new()
	var material = StandardMaterial3D.new()
	
	# Set up cylinder
	cylinder.height = rod_length
	cylinder.top_radius = 0.05
	cylinder.bottom_radius = 0.05
	cylinder.material = material

	# Set up material
	material.albedo_color = Color.DARK_GRAY

	rod_mesh_instance.mesh = cylinder
	# Shift the rod mesh down by half its height so that the top is at the rod_node's origin
	rod_mesh_instance.transform.origin.y = -rod_length / 2

func create_mass(parent_rod: Node3D, rod_length: float, mass_name: String):
	var mass = MeshInstance3D.new()
	mass.name = mass_name  # Set the name for reference

	var sphere_mesh = SphereMesh.new()
	var material = StandardMaterial3D.new()
	
	# Set up sphere
	sphere_mesh.radius = 0.15
	sphere_mesh.height = 0.3
	sphere_mesh.material = material

	# Set up material
	material.albedo_color = Color(0, 0, 1)  # Blue
	material.metallic = 0.7
	material.roughness = 0.3

	mass.mesh = sphere_mesh
	mass.position.y = -rod_length  # Place at end of rod
	
	# Add to scene
	parent_rod.add_child(mass)
	mass.owner = get_tree().edited_scene_root
