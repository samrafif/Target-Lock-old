extends RigidBody3D
class_name AeroPhysicsBody3D

var SUBSTEPS : int = ProjectSettings.get_setting("physics/3d/aerodynamics/substeps", 1):
	set(x):
		SUBSTEPS = x
		PREDICTION_TIMESTEP_FRACTION = 1.0 / float(SUBSTEPS)
	get:
		return ProjectSettings.get_setting("physics/3d/aerodynamics/substeps", 1)
var PREDICTION_TIMESTEP_FRACTION : float = 1.0 / float(SUBSTEPS)

@export var debug: bool = false
var aero_influencers : Array[AeroInfluencer3D] = []

var current_force := Vector3.ZERO
var current_torque := Vector3.ZERO
@onready var last_linear_velocity : Vector3 = linear_velocity
@onready var last_angular_velocity : Vector3 = angular_velocity
var air_velocity := Vector3.ZERO
var wind := Vector3.ZERO
var air_speed := 0.0

# instrumentation data, TODO: move to its own module later
var air_density : float = 0.0
var mach := 0.0
var sideslip_ang := 0.0
var heading := 0.0
var pitch := 0.0
var bank_angle := 0.0

# vars for calculating forces
var linear_velocity_prediction : Vector3 = linear_velocity
var angular_velocity_prediction : Vector3 = angular_velocity
var substep_delta : float = get_physics_process_delta_time() / SUBSTEPS

func on_child_enter_tree(node : Node) -> void:
	if node is AeroInfluencer3D:
		aero_influencers.append(node)
		node.aero_body = self

func on_child_exit_tree(node : Node) -> void:
	if node is AeroInfluencer3D and aero_influencers.has(node):
		aero_influencers.erase(node)
		node.aero_body = null

func _init() -> void:
	pass

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Engine.is_editor_hint():
		# TODO: Add config warnings
		pass

func _get_configuration_warnings() -> PackedStringArray:
	var warnings := PackedStringArray()
	# NOT_IMPLEMENTED
	return warnings

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta) -> void:
	if debug:
		_update_debug()

func _integrate_forces(state: PhysicsDirectBodyState3D) -> void:
	if state.sleeping or SUBSTEPS == 0:
		return
	
	intgerator(state)

func intgerator(state: PhysicsDirectBodyState3D) -> void:
	var total_force_torque = calculate_forces(state)
	current_force = total_force_torque[0]
	current_torque = total_force_torque[1]
	state.apply_central_force(current_force)
	state.apply_torque(current_torque)

func calculate_forces(state: PhysicsDirectBodyState3D) -> PackedVector3Array:
	
	
	
	return PackedVector3Array([Vector3.ZERO, Vector3.ZERO])

func setup_forces():
	pass

func _update_debug():
	pass
