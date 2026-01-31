extends Node2D
class_name asap2d
@onready var col: Area2D = $COL
@onready var player :IlmuanBody2D = get_tree().get_first_node_in_group("ilmu")

func _on_col_body_entered(bodyde: Node2D) -> void:
	var body = bodyde.get_parent()
	if body is EnemyBody2D:
		if body.death:
			return
		body.health_index -= 0.05
		if body.health_index <= 0.0 and (body.health_index + 0.05 > 0):
			player.world.killed += 1
		player.hitted_virus.emit("Normal")

func _process(delta: float) -> void:
	position.y -= delta*64
