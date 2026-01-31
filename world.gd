extends Node2D
var spawned :int = 0
var killed :int = 0:
	set(value):
		killed = value
		if killed == spawned:
			entity.boss_spwn()
@onready var entity: Node2D = $Entity
