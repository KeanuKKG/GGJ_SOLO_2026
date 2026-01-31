extends Node2D
class_name Sync2D
@export var Nodes:Node2D

func _physics_process(delta: float) -> void:
	global_position = Nodes.global_position
