# Double Pendulum Simulation in Godot Engine
 
**Overview**
- This project is a simulation of a double pendulum using the Godot Engine (version 4). It demonstrates the complex, chaotic. Motion of a double pendulum system in a 3D environment. The simulation uses GDScript to model both the physics and visual representation of the pendulum.

https://github.com/user-attachments/assets/e98fc45c-3c76-4549-be5b-7af3167424c9

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


**Installation**
- Prerequisites:
  Godot Engine 4.x: Download and install from the official website.
 
**Steps:**
1. Clone the Repository
   git clone https://github.com/yourusername/double-pendulum-godot.git
2. Open the Project in Godot
   - Launch Godot Engine.
   - Click on "Import".
   - Navigate to the cloned repository folder.
   - Select the project.godot file.
   - Click "Import & Edit".
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

 - The node hierarchy is crucial for the correct functioning of the simulation.
 
				PendulumSystem (Node3D)
				├── Pivot (Node3D)
				│   ├── Support (MeshInstance3D)
				│   └── Arm1 (Node3D)
				│       ├── Mass1 (MeshInstance3D)
				│       └── Arm2 (Node3D)
				│           └── Mass2 (MeshInstance3D)
				 
**Usage:**
1. Running the Simulation
	- Open the project in Godot Engine.
	- Press F5 or click the Play button to run the simulation.
	- The double pendulum will start swinging based on the initial parameters. 
2. Observing the Simulation
	- Adjust your camera to view the pendulum from the side for the best perspective.
	- Watch the pendulum's motion and observe the chaotic behavior typical of a double pendulum.
	 
**Customization:**
 - You can customize the simulation by modifying the exported variables in pendulum_system.gd.

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
	- @export var initial_angle_1: float = PI / 4  # 45 degrees
	- @export var initial_angle_2: float = PI / 4
- Initial Angular Velocities
	- @export var initial_velocity_1: float = 0.0
	- @export var initial_velocity_2: float = 0.0
**Debug Settings**
- Enable Debug Mode
	- @export var debug_mode: bool = true
- Pause Simulation on Start
	- @export var pause_simulation: bool = false

**How to Customize:**
1. Open pendulum_system.gd
   - Navigate to scripts/pendulum_system.gd in the Godot Editor.
2. Modify Exported Variables
   - Adjust the variables under the "Pendulum Properties" and "Initial Conditions" export groups.
3. Save and Run
   - Save your changes and run the project to see the effects.
 
**Controls:**
- Pause/Resume Simulation
- Press the Esc key to pause or resume the simulation.
- Reset Simulation
- Press the Enter key to reset the simulation to its initial conditions.
 
**Scripts Overview:**
- **setup_scene.gd**
   - This script is attached to a Node3D and is responsible for setting up the visual components of the pendulum system.
 
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

- This script is attached to the PendulumSystem node and handles the physics simulation.
	 
**Responsibilities**
- Physics Calculation
- Computes angular accelerations, velocities, and positions.
- Uses the equations of motion for a double pendulum.
- Updating Positions
- Applies rotations to the pendulum arms based on calculated angles.
- User Input Handling
- Pauses, resumes or resets the simulation based on user input.
 
**Key Functions:**
- _physics_process(delta): Updates the physics simulation at each physics frame.
- calculate_physics(delta): Performs the physics calculations.
- update_positions(): Updates the visual positions of the pendulum arms.
- _input(event): Handles user input for pausing and resetting.
- reset_simulation(): Resets the simulation to initial conditions.
 
 **Example Snippet**
 
			func _physics_process(delta):
			  if pause_simulation:
			    return
			   calculate_physics(delta)
			     update_positions()
			    
			  if debug_mode:
			    debug_state()
		 
# Troubleshooting and Debugging Guide

This section outlines common problems encountered during the development of the double pendulum simulation, their causes, and applied solutions.

## 1. Simulation Not Updating at 60 FPS

### Problem
The pendulum simulation was not updating as expected; the motion was either non-existent or incorrect.

### Cause
The `_physics_process(delta)` method was missing from the `pendulum_system.gd` script. This method is essential for updating the simulation at the default physics tick rate of 60 times per second.

### Effects
- The pendulum does not move when the simulation runs
- The motion is erratic or not in real-time
- Continuous updates to the pendulum's state are absent

### Solution
Added the `_physics_process(delta)` Method:

```gdscript
func _physics_process(delta):
    if pause_simulation:
        return

    calculate_physics(delta)
    update_positions()

    if debug_mode:
        debug_state()
```

### Debugging Steps
1. Verified that `_physics_process(delta)` was not present
2. Added the method and observed that the simulation began updating correctly
3. Confirmed the update rate by printing the physics frames or using the debugger

## 2. Incorrect Node Hierarchy Affecting Transformations

### Problem
The pendulum arms were not rotating or moving correctly because the node hierarchy did not reflect the necessary parent-child relationships.

### Cause
The node hierarchy was not correctly established, so transformations and rotations did not propagate as expected.

### Effects
- Arm2 does not follow the movement of Arm1
- Rotations and transformations do not propagate correctly
- Visual discrepancies in the pendulum's motion

### Solution
#### Ensured Correct Hierarchy:
```gdscript
func create_pendulum():
    # Create Arm1
    arm1 = Node3D.new()
    arm1.name = "Arm1"
    pivot.add_child(arm1)
    arm1.position = Vector3.ZERO

    # Create Arm2
    arm2 = Node3D.new()
    arm2.name = "Arm2"
    arm1.add_child(arm2)
    arm2.position = Vector3(0, -rod_length_1, 0)  # Position at end of Arm1

    # Create the rods and masses
    create_rod(arm1, rod_length_1)
    create_rod(arm2, rod_length_2)
    create_mass(arm1, rod_length_1, "Mass1")
    create_mass(arm2, rod_length_2, "Mass2")
```

## 3. Git Conflicts When Pushing Changes

### Problem
Errors occurred when pushing local commits to the remote repository due to divergent branches.

### Cause
The local and remote main branches had diverged; the remote branch contained commits that were not in the local branch.

### Solution
1. Merged Remote Changes into Local Branch:
```bash
git pull origin main --no-rebase
```
2. Resolved any merge conflicts that arose
3. Pushed Local Changes:
```bash
git pull origin main
```

## 4. Nodes Not Referenced Correctly

### Problem
Errors occurred due to nodes not being found or referenced correctly in the scripts.

### Solution
Updated node references to use correct paths:

```gdscript
@onready var mass1 = $Pivot/Arm1/Mass1
```

### Debugging Steps
1. Check scene tree for correct node names and hierarchy
2. Use print statements to verify node references
3. Update node paths in scripts accordingly

# Assertions and Error Handling

To enhance the reliability and robustness of our double pendulum simulation, we have implemented strategic assert function calls within the GDScript code. These assertions serve as internal checks to verify that certain conditions hold true at specific points in the code.

## Purpose of Assertions

- **Early Error Detection**: Catch potential issues during development rather than at runtime
- **Documentation**: Clearly indicate the assumptions and invariants within the code
- **Debugging Aid**: Help identify incorrect states and make debugging easier

## Implementation Details

### 1. Verifying Node Initialization

We ensure that all essential nodes are correctly initialized and not null to prevent null reference errors during execution.

```gdscript
func _ready():
    # Assert that critical nodes are not null
    assert(pivot != null, "Pivot node is not initialized.")
    assert(arm1 != null, "Arm1 node is not initialized.")
    assert(arm2 != null, "Arm2 node is not initialized.")
    assert(mass1 != null, "Mass1 node is not initialized.")
    assert(mass2 != null, "Mass2 node is not initialized.")
```

### 2. Validating Input Parameters

We validate that exported variables and input parameters have acceptable values:

```gdscript
func _ready():
    # Assert that rod lengths are positive
    assert(rod_length_1 > 0, "rod_length_1 must be greater than zero.")
    assert(rod_length_2 > 0, "rod_length_2 must be greater than zero.")

    # Assert that masses are positive
    assert(mass_1 > 0, "mass_1 must be greater than zero.")
    assert(mass_2 > 0, "mass_2 must be greater than zero.")
```

### 3. Preventing Division by Zero in Physics Calculations

```gdscript
func calculate_physics(delta):
    # Calculate denominators
    var den1 = l1 * (2.0 * m1 + m2 - m2 * cos(2.0 * (theta1 - theta2)))
    var den2 = l2 * (2.0 * m1 + m2 - m2 * cos(2.0 * (theta1 - theta2)))

    # Assert that denominators are not zero
    assert(abs(den1) > 0.000001, "Denominator den1 is too close to zero.")
    assert(abs(den2) > 0.000001, "Denominator den2 is too close to zero.")
```

## Testing the Assertions

1. **Trigger an Assertion Failure**:
   - Set an invalid value (e.g., `rod_length_1 = 0`)
   - Run the simulation
   
2. **Observe the Error Message**:
   - Simulation halts with clear error message
   - Example: "Assertion failed: rod_length_1 must be greater than zero."
   
3. **Correct the Value**:
   - Restore valid value
   - Verify simulation runs without errors

## Benefits of Using Assertions

- **Improved Reliability**: Validation of critical conditions reduces runtime errors
- **Easier Debugging**: Clear and immediate feedback when assumptions are violated
- **Code Documentation**: Serves as executable documentation of code requirements

## Important Considerations

### Development vs. Production
- Assertions are active in debug builds
- Ignored in release builds
- No performance impact in final product

### Appropriate Usage
- Assertions catch programming errors, not user input errors
- User input validation should be handled separately with proper error handling

---
