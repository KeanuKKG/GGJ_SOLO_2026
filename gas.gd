extends Node2D
class_name gas2d
@onready var asep: Sprite2D = $DREZ/ASEP
@onready var player :IlmuanBody2D = get_tree().get_first_node_in_group("ilmu")

var direction :Vector2
var start_poss :Vector2
var ranges := 725.0

func _ready() -> void:
	asep.texture.noise.offset.x = randf_range(0, 1000)
	direction = Vector2.RIGHT.rotated(rotation)
	global_position = start_poss

func _physics_process(delta: float) -> void:
	global_position = global_position.lerp(start_poss + (direction * ranges), delta*0.5)

func _on_col_body_entered(bodyde: Node2D) -> void:
	var body = bodyde.get_parent()
	if body is EnemyBossBody2D:
		body.health_index -= 0.0025
		if body.death and (body.health_index + 0.0025 > 0):
			player.world.killed += 1
		player.hitted_virus.emit("Boss")
