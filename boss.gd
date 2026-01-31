extends Node2D
class_name EnemyBossBody2D
@onready var mask: Sprite2D = $Enem/Mask
@onready var maskout: AnimationPlayer = $Enem/Mask/Maskout
@onready var n_am: Label = $Healtbar/Type/Bosses/NAm
@onready var bosses: ProgressBar = $Healtbar/Type/Bosses
@onready var n_am_d: Label = $Healtbar/Type/Bosses/NAmD
@onready var hit: AnimationPlayer = $Enem/HIT

const RAD :float = 2.5
const ALLTEXT := [preload("uid://b2eqfcjbduyr1"), preload("uid://cjb2b8mbf8gpg"), preload("uid://bcj4de5o4kdg2"), preload("uid://bw8ppfekvhg7e")]
var player_node :IlmuanBody2D
var death := false
var health_index := 4.0:
	set(value):
		if value < health_index:
			hit.seek(0.0, true)
			hit.play("HITTED")
		if value <= 0.0 and health_index > 0 and !death:
			death = true
			maskout.play("Out")
		health_index = value
		n_am_d.text = str(floor((max(health_index, 0.0)/4.0) * 100))+"/100"
		bosses.value = (health_index/4.0) * 100


func _ready() -> void:
	player_node = get_tree().get_first_node_in_group("ilmu")

func _physics_process(delta: float) -> void:
	_handle_movement(delta)

func _handle_movement(delta:float) -> void:
	mask.texture = ALLTEXT[min(abs(int(health_index) - 4), 3)]

func move_toward_vector2d(vectA:Vector2, vectB:Vector2, Move:float) -> Vector2:
	return Vector2(move_toward(vectA.x, vectB.x, Move), move_toward(vectA.y, vectB.y, Move))
