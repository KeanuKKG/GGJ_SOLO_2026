extends Label
@onready var player :IlmuanBody2D = get_tree().get_first_node_in_group("ilmu")

func _ready() -> void:
	var Twener := create_tween()
	Twener.set_parallel()
	Twener.set_trans(Tween.TRANS_CUBIC)
	scale = Vector2.ZERO
	Twener.tween_property(self, "scale", Vector2.ONE * randf_range(1, 1.25), 0.25)
	Twener.tween_property(self, "global_position", global_position - Vector2(randf_range(15,57), randf_range(5,57)), 0.375)
	Twener.tween_property(self, "rotation", TAU, 0.25)
	Twener.tween_property(self, "self_modulate:a", 0.0, 0.125).set_delay(randf_range(0.375, 1.0))
	await Twener.finished
	queue_free()
