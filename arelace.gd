extends VBoxContainer
@onready var asder: Label = $"../AS"
@onready var axd: Sprite2D = $"../AS/AXD"
const indexed_scene := ["res://world.tscn"]

func _ready() -> void:
	for a in get_children():
		if a is Button:
			a.pressed.connect(some_button_pressed.bind(a.get_index()))

func some_button_pressed(index:int) -> void:
	if indexed_scene.size() > index:
		get_tree().change_scene_to_file(indexed_scene[index])

func _process(delta: float) -> void:
	asder.position.x = lerpf(asder.position.x, 23.0 if !asder.get_rect().has_point(get_global_mouse_position()) else 110.0, delta*8)
	axd.self_modulate.a = lerpf(axd.self_modulate.a, 0.0 if !asder.get_rect().has_point(get_global_mouse_position()) else 1.0, delta*8)
	for a in get_children():
		if a is Button:
			a.custom_minimum_size.y = lerpf(a.custom_minimum_size.y, 55.0 if !a.is_hovered() else 95.0,delta*8)
