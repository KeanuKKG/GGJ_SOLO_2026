extends Node

const idc := preload("res://indicator_text.tscn")

func add_text_indicator(positione:Vector2, string:String, colour:Color = Color.WHITE) -> void:
	var txt :Label= idc.instantiate()
	txt.global_position = positione
	add_child(txt)
	txt.text = string
	txt.label_settings.font_color = colour
