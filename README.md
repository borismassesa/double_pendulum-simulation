# Double Pendulum Simulation in Godot Engine
 
**Overview**
This project is a simulation of a double pendulum using the Godot Engine (version 4). It demonstrates the complex, chaotic .
motion of a double pendulum system in a 3D environment. The simulation uses GDScript to model both the physics and visual
representation of the pendulum.
 
(Include a screenshot of your simulation here)
 
**Features**
- Accurate Physics Simulation: Implements the equations of motion for a double pendulum to simulate realistic behavior.
- Real-Time Updates: Uses the _physics_process(delta) method to update the simulation 60 times per second.
- Hierarchical Node Structure: Utilizes a node hierarchy to correctly apply transformations and rotations.
- Customizable Parameters: Easily adjust rod lengths, masses, initial angles, gravity, and damping factors.
- Visual Elements: Includes visual representations of rods, masses, and a support structure.
- Debug Mode: Optional debug outputs to monitor the simulation state.
- User Controls: Pause, resume, and reset the simulation using keyboard inputs.
 
**Table of Contents**
1. Installation
2. Project Structure
3. Usage
4. Customization
5. Controls
6. Scripts Overview
7. setup_scene.gd
8. pendulum_system.gd
9. Troubleshooting
10. License


**Installation**
Prerequisites:
 
Godot Engine 4.x: Download and install from the official website.
 
**Steps:**
1. Clone the Repository
   git clone https://github.com/yourusername/double-pendulum-godot.git
2. Open the Project in Godot
   - Launch Godot Engine.
   - Click on “Import”.
   - Navigate to the cloned repository folder.
   - Select the project.godot file.
   - Click “Import & Edit”.
3. Run the Project
   - Press the Play button or press F5 to start the simulation.
 
**Project Structure:**
double-pendulum-godot/
	├── assets/
	│   └── double_pendulum_screenshot.png
	├── scenes/
	│   ├── Main.tscn
	│   └── PendulumSystem.tscn
	├── scripts/
	│   ├── setup_scene.gd
	│   └── pendulum_system.gd
	├── project.godot
	└── README.md
 
- assets/: Contains images and other assets.scenes/:
- Godot scene files.
- scripts/: GDScript files. project.godot: Godot project file.
- README.md: This readme file.
 
Node Hierarchy:
 The node hierarchy is crucial for the correct functioning of the simulation.
 
	PendulumSystem (Node3D)
	├── Pivot (Node3D)
	│   ├── Support (MeshInstance3D)
	│   └── Arm1 (Node3D)
	│       ├── RodMesh (MeshInstance3D)
	│       ├── Mass1 (MeshInstance3D)
	│       └── Arm2 (Node3D)
	│           ├── RodMesh (MeshInstance3D)
	│           └── Mass2 (MeshInstance3D)
	 
**Usage:**
1. Running the Simulation
- Open the project in Godot Engine.
- Press F5 or click the Play button to run the simulation.
- The double pendulum will start swinging based on the initial parameters.
 
2. Observing the Simulation
- Adjust your camera to view the pendulum from the side for the best perspective.
- Watch the pendulum’s motion and observe the chaotic behavior typical of a double pendulum.
 
**Customization:**
You can customize the simulation by modifying the exported variables in pendulum_system.gd.

Pendulum Properties:
- Rod Lengths
	- @export var rod_length_1: float = 1.0
    	- @export var rod_length_2: float = 1.0
 - Masses
	- @export var mass_1: float = 1.0
 	- @export var mass_2: float = 1.0
- Gravity
	- @export var gravity: float = 9.81
- Damping
	- @export var damping: float = 0.999

**Initial Conditions:**
- Initial Angles (in radians)
	@export var initial_angle_1: float = PI / 4  # 45 degrees
	@export var initial_angle_2: float = PI / 4
 - Initial Angular Velocities
	@export var initial_velocity_1: float = 0.0
	@export var initial_velocity_2: float = 0.0
Debug Settings
- Enable Debug Mode
	@export var debug_mode: bool = true
- Pause Simulation on Start
	@export var pause_simulation: bool = false

**How to Customize:**
1. Open pendulum_system.gd
   - Navigate to scripts/pendulum_system.gd in the Godot Editor.
2. Modify Exported Variables
   - Adjust the variables under the “Pendulum Properties” and “Initial Conditions” export groups.
3. Save and Run
   - Save your changes and run the project to see the effects.
 
**Controls:**
- Pause/Resume Simulation
- Press the Esc key to pause or resume the simulation.
- Reset Simulation
- Press the Enter key to reset the simulation to its initial conditions.
 
**Scripts Overview:**
**setup_scene.gd** 
This script is attached to a Node3D and is responsible for setting up the visual components of the pendulum system.
 
**Responsibilities:**
- Creating Visual Elements
- Rods are represented by cylinders.
- Masses are represented by spheres.
- A support structure is added at the top.
- Positioning
- Rods and masses are positioned based on the rod lengths.
- The support is positioned above the pivot point.
 
**Key Functions:**
- create_pendulum(): Initializes the pendulum arms and masses.
- create_rod(rod_node, rod_length): Creates a rod mesh and attaches it to the specified node.
- create_mass(parent_rod, rod_length, mass_name): Creates a mass mesh and attaches it to the end of a rod.
- create_support(): Creates the support structure at the top of the pendulum.
 
**Example Snippet:**
func create_rod(rod_node: Node3D, rod_length: float):
    var rod_mesh_instance = MeshInstance3D.new()
    rod_node.add_child(rod_mesh_instance)
    rod_mesh_instance.name = "RodMesh"
 
    var cylinder = CylinderMesh.new()
    cylinder.height = rod_length
    cylinder.top_radius = 0.05
    cylinder.bottom_radius = 0.05
 
    rod_mesh_instance.mesh = cylinder
    rod_mesh_instance.transform.origin.y = -rod_length / 2
 
**pendulum_system.gd**
This script is attached to the PendulumSystem node and handles the physics simulation.
 
**Responsibilities**
- Physics Calculation
- Computes angular accelerations, velocities, and positions.
- Uses the equations of motion for a double pendulum.
- Updating Positions
- Applies rotations to the pendulum arms based on calculated angles.
- User Input Handling
- Pauses, resumes, or resets the simulation based on user input.
 
Key Functions
 • _physics_process(delta): Updates the physics simulation at each physics frame.
 • calculate_physics(delta): Performs the physics calculations.
 • update_positions(): Updates the visual positions of the pendulum arms.
 • _input(event): Handles user input for pausing and resetting.
 • reset_simulation(): Resets the simulation to initial conditions.
 
**Example Snippet**
func _physics_process(delta):
    if pause_simulation:
        return
 
    calculate_physics(delta)
    update_positions()
 
    if debug_mode:
        debug_state()
 
**Troubleshooting** 
Simulation Not Running
- Ensure Scripts are Attached
- Verify that setup_scene.gd is attached to the appropriate node in your scene.
- Check Node Paths
- Ensure that the node paths in the scripts match your Scene Tree structure.
 
Visual Elements Missing
- Confirm Node Creation
- Make sure that create_pendulum() and create_support() are being called.
- Owner Assignment
- When adding nodes dynamically, ensure they have the correct owner:
 
node.owner = get_tree().edited_scene_root
Physics Not Updating
- Check _physics_process(delta)
- Ensure that this function exists and is correctly implemented in pendulum_system.gd.
- Verify Physics FPS
- The default physics tick rate is 60 FPS. Check your project settings under Project > Project Settings > Physics > Common > Physics FPS.

Unexpected Behavior
- Debug Output
- Enable debug_mode to print out state information.
- Parameter Values
- Verify that masses, lengths, and initial angles are within reasonable ranges.
 
**License**
This project is licensed under the MIT License. See the LICENSE file for details.
