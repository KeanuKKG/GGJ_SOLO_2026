extends CharacterBody2D
class_name IlmuanBody2D
@onready var asap: Node2D = $Senjatas/Asap

const SPEED := 325.0
const SPRINT_SPEED := 1.25
const FRICTION := 150.0
const GAS := preload("res://asap.tscn")
var time :float = 0.0
var direction_input :Vector2

func _physics_process(delta: float) -> void:
	_handle_movement(delta)
	_handle_weapon(delta)
	move_and_slide()

func gassing() -> void:
	var asapm := GAS.instantiate()
	asapm.global_position = asap.global_position + Vector2(0, randf_range(-25, 25))
	asapm.scale = Vector2.ONE * randf_range(0.25,0.75)
	asapm.rotation = randf_range(-PI, PI)
	asap.add_child(asapm)

func _handle_movement(delta:float) -> void:
	direction_input = Input.get_vector("KIRI", "KANAN", "ATAS", "BAWAH")
	var DecSpeed := direction_input * SPEED
	if direction_input:
		velocity = move_toward_vector2d(velocity, DecSpeed, FRICTION * (delta * 32))
	else:
		velocity = move_toward_vector2d(velocity, Vector2.ZERO, FRICTION * (delta * 6))

func _handle_weapon(delta:float) -> void:
	if Input.is_action_pressed("GASS"):
		gassing()

func move_toward_vector2d(vectA:Vector2, vectB:Vector2, Move:float) -> Vector2:
	return Vector2(move_toward(vectA.x, vectB.x, Move), move_toward(vectA.y, vectB.y, Move))
