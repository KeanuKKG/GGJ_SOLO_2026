extends CharacterBody2D
class_name IlmuanBody2D
@onready var asap: Node2D = $Senjatas/Asap
@onready var awa: Sprite2D = $AWA
@onready var ap: AnimationPlayer = $AWA/AP
@onready var cam: Camera2D = $CAM
@onready var hands: Node2D = $AWA/Hands
@onready var hand_ol: Sprite2D = $AWA/Hands/HandOL
@onready var world: Node2D = $"../.."
@onready var gas_trhower: Sync2D = $Senjatas/GasTrhower
@onready var allsprite := [$AWA/Hands/HandOL/OVRX, $AWA/Hands/HandOL/OVR]
@onready var sc: TextureRect = $UI/ID/Weapon/SC
@onready var anim_h: AnimationPlayer = $AWA/Hands/AnimH
@onready var ammo: ProgressBar = $UI/ID/AMMO

const SPEED := 225.0
const SPRINT_SPEED := 1.25
const FRICTION := 150.0
const GAS := preload("res://asap.tscn")
const GES := preload("res://gas.tscn") 
const prechache := [preload("uid://bvpmbx737my61"), preload("uid://dbrvludloh3j1")]
const pretexture := [preload("uid://bb5b1edp21hxx"), preload("uid://lm2wiii48cpk")]
var time :float = 0.0
var direction_input :Vector2
var index_gun := 0
var played_indx := 0
var ALAMO := [
	100.0,
	100.0
]
signal hitted_virus(type:String)

func _physics_process(delta: float) -> void:
	_handle_movement(delta)
	_handle_weapon(delta)
	_handle_animation(delta)
	move_and_slide()

func gassing() -> void:
	var asapm := GAS.instantiate()
	asapm.global_position = asap.global_position + Vector2(0, randf_range(-15, 15))
	asapm.scale = Vector2.ONE * randf_range(0.25,0.75)
	asapm.rotation = randf_range(-PI, PI)
	asap.add_child(asapm)

func gassed() -> void:
	var asapm := GES.instantiate()
	asapm.start_poss = gas_trhower.global_position + Vector2(0, randf_range(-25, 25))
	asapm.scale = Vector2.ONE * randf_range(0.25,0.75)
	asapm.rotation = Vector2(-1 if awa.flip_h else 1, 0).angle() + randf_range(-PI/12, PI/12)
	gas_trhower.add_child(asapm)

func _handle_movement(delta:float) -> void:
	sc.texture = null if index_gun == 0 else (pretexture[index_gun-1])
	direction_input = Input.get_vector("KIRI", "KANAN", "ATAS", "BAWAH")
	cam.zoom = cam.zoom.lerp(Vector2.ONE / max((velocity.length() / SPEED), 0.422), delta* 8)
	if direction_input.x:
		awa.flip_h = direction_input.x <= 0
	if awa.flip_h:
		hands.scale.x = -1
	else:
		hands.scale.x = 1
	var DecSpeed := direction_input * SPEED
	if direction_input:
		velocity = move_toward_vector2d(velocity, DecSpeed, FRICTION * (delta * 32))
	else:
		velocity = move_toward_vector2d(velocity, Vector2.ZERO, FRICTION * (delta * 6))

func _handle_animation(delta:float) -> void:
	if floor(velocity.length()):
		ap.play("Walk")
	else:
		ap.play("Idle")
	cam.offsetos = (((global_position + get_global_mouse_position())/2) - global_position) / 4

func _handle_weapon(delta:float) -> void:
	if Input.is_action_pressed("GASS"):
		gassing()
		index_gun = 1
	elif Input.is_action_pressed("TRHO"):
		if (sign(get_local_mouse_position().x) == (-1 if awa.flip_h else 1)):
			gassed()
		index_gun = 2
	else:
		index_gun = 0
	if index_gun != 0:
		ammo.show()
		ammo.value = ALAMO[index_gun-1]
		ALAMO[index_gun-1] -= 0.1
	else:
		ammo.hide()
	for a in 3:
		if a != 0:
			allsprite[a-1].visible = a == index_gun
			if played_indx != index_gun and a == index_gun:
				anim_h.play("X"+str(a))
				played_indx = index_gun
			if a != index_gun:
				allsprite[a-1].hide()
		else:
			if index_gun == 0:
				played_indx = 0
			for bx in hand_ol.get_children():
				bx.hide()
	if index_gun == 0:
		anim_h.play("RESET")
	awa.texture = prechache[1] if index_gun != 0 else prechache[0]

func move_toward_vector2d(vectA:Vector2, vectB:Vector2, Move:float) -> Vector2:
	return Vector2(move_toward(vectA.x, vectB.x, Move), move_toward(vectA.y, vectB.y, Move))

func _on_hitted_virus(type:String) -> void:
	match type:
		"Boss":cam.shakes()
		"Normal":cam.shakesex()
