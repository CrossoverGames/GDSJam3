extends Area2D

export(float) var health = 100.0

onready var lifebar = get_node("LifeBar")
onready var delete_timer = get_node("DeadTimer")

var ripped = false
var active = true

func _ready():
	lifebar.update_max_hp(health)
	lifebar.set_value(health)
	
	connect("body_enter", self, "on_body_enter")
	connect("body_exit", self, "on_body_exit")

func on_body_enter(body):
	if ripped or not active: return
	if body.is_in_group("lion"):
		body.get_node("Blocked").set_active(true)

func on_body_exit(body):
	if body.is_in_group("lion"):
		body.get_node("Blocked").set_active(false)

func scare(points):
	if not active or ripped: return
	health -= points
	if health <= 0:
		health = 0
		rip()
	lifebar.set_value(health)

func rip():
	ripped = true
	get_node("sprite").play("rip")
	var bodies = get_overlapping_bodies()
	for body in bodies:
		if body.is_in_group("lion"):
			body.get_node("Blocked").set_active(false)
	delete_timer.start()

func set_active(value):
	active = value

func delete():
	queue_free()
