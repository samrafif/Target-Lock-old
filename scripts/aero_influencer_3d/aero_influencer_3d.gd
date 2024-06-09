extends Node3D
class_name AeroInfluencer3D

signal on_child_exit_tree(node)
signal on_child_enter_tree(node)

@export var disabled : bool = false
@export var show_debug: bool = false

var _current_force := Vector3.ZERO
var _current_torque := Vector3.ZERO

var world_air_velocity := Vector3.ZERO
var linear_velocity := Vector3.ZERO
var angular_velocity := Vector3.ZERO
@onready var last_linear_velocity : Vector3 = linear_velocity
@onready var last_angular_velocity : Vector3 = angular_velocity

var local_air_velocity := Vector3.ZERO
var air_speed := 0.0
var air_density := 0.0
var dynamic_pressure := 0.0
var relative_position := Vector3.ZERO

func _enter_tree():
	on_child_enter_tree.emit(self)

func _exit_tree():
	on_child_exit_tree.emit(self)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _calculate_forces(substep_delta):
	pass

func get_relative_position() -> Vector3:
	return get_parent().get_relative_position() + (get_parent().global_basis * position)

func get_world_air_velocity() -> Vector3:
	return -get_linear_velocity()

func get_linear_velocity() -> Vector3:
	return get_parent().get_linear_velocity() + get_parent().get_angular_velocity().cross(get_parent().global_basis * position)

func get_angular_velocity() -> Vector3:
	return get_parent().get_angular_velocity()

func debug_vectors() -> Array[Vector3]:
	return []
