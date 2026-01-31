extends Control
@onready var ava: AnimationPlayer = $DPS/AVA

func _on_cds_pressed() -> void:
	ava.play("X_C")

func _on_ava_animation_finished(anim_name: StringName) -> void:
	if anim_name == "X_C":
		get_tree().change_scene_to_file("res://interface.tscn")
