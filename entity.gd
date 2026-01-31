extends Node2D
@onready var world: Node2D = $".."
@onready var ilmuan: IlmuanBody2D = $Ilmuan
const enemy := preload("res://enemy.tscn")

func enemy_spwn(vale:int) -> void:
	for a in vale:
		world.spawned += 1
		var enemyse := enemy.instantiate()
		enemyse.global_position = ilmuan.global_position + Vector2(randf_range(-500,500),randf_range(-500,500))
		add_child(enemyse)

func _ready() -> void:
	enemy_spwn(15)

func boss_spwn() -> void:
	var boss = preload("res://boss.tscn").instantiate()
	boss.global_position = Vector2(500, -8)
	add_child(boss)
