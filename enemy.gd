extends CharacterBody2D
class_name EnemyBody2D
@onready var mask: Sprite2D = $Enem/Mask
@onready var maskout: AnimationPlayer = $Enem/Mask/Maskout
@onready var colsi: CollisionShape2D = $Colsi
@onready var hit: AnimationPlayer = $Enem/HIT
@onready var collision_shape_2d: CollisionShape2D = $Hurbox/CollisionShape2D

var direction_input :Vector2
const RAD :float = 250.5
const SPEED := 150.0
const SPRINT_SPEED := 1.25
const FRICTION := 150.0
const ALLTEXT := [preload("uid://bf7dst3php3ox"), preload("uid://dt2eabgdq7d4u"), preload("uid://bky2wopdib1rq"), preload("uid://c6pee4jkwq88k")]
var player_node :IlmuanBody2D
var death := false
var health_index := 4.0:
	set(value):
		if value < health_index:
			hit.seek(0.0, true)
			hit.play("HITTED")
			noda_dar()
			Globals.add_text_indicator(global_position,str(floor(((health_index - value)/4.0)*1000)), Color.REBECCA_PURPLE)
		if value <= 0.0 and health_index > 0 and !death:
			death = true
			maskout.play("Out")
		health_index = value

func _ready() -> void:
	player_node = get_tree().get_first_node_in_group("ilmu")

func _physics_process(delta: float) -> void:
	_handle_movement(delta)
	move_and_slide()

func noda_dar() -> void:
	var node := preload("res://blood.tscn").instantiate()
	node.global_position = global_position
	add_child(node)

func _handle_movement(delta:float) -> void:
	mask.texture = ALLTEXT[min(abs(int(health_index) - 4), 3)]
	direction_input = global_position.direction_to(player_node.global_position)
	if global_position.distance_squared_to(player_node.global_position) > pow(RAD,2):
		direction_input *= 0
	if global_position.distance_squared_to(player_node.global_position) <= pow(RAD/8,2):
		direction_input *= -1
	colsi.disabled = health_index <= 0.0
	if !maskout.is_playing() and health_index <= 0.0:
		direction_input *= 0
	var DecSpeed := direction_input * SPEED
	if direction_input and !maskout.is_playing():
		velocity = move_toward_vector2d(velocity, DecSpeed, FRICTION * (delta * 32))
	else:
		velocity = move_toward_vector2d(velocity, Vector2.ZERO, FRICTION * (delta * 6))

func move_toward_vector2d(vectA:Vector2, vectB:Vector2, Move:float) -> Vector2:
	return Vector2(move_toward(vectA.x, vectB.x, Move), move_toward(vectA.y, vectB.y, Move))
