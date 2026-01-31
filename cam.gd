extends Camera2D
var offsetos :Vector2 
var shake :Vector2
var value := 0.0
var speed := 16.0

func _physics_process(delta: float) -> void:
	shake = Vector2(randf_range(-value,value), randf_range(-value,value))
	offset = offsetos + shake
	value = lerpf(value, 0.0, delta*speed)

func shakes() -> void:
	value = 6.25

func shakesex() -> void:
	value = 3.125
