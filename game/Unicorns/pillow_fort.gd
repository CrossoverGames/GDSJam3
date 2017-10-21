extends Node

export(float) var health = 100.0

onready var lifebar = get_node("LifeBar")

var ripped = false
var active = true

func _ready():
	lifebar.update_max_hp(health)
	lifebar.set_value(health)

func scare(points):
	if not active or ripped: return
	health -= points
	if health <= 0:
		health = 0
		rip()
	lifebar.set_value(health)

func rip():
	ripped = true
#	get_node("sprite").play("rip")
	queue_free()

func set_active(value):
	active = value
