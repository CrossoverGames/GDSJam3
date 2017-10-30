extends Area2D

func _ready():
	connect("body_enter", self, "on_body_enter")

func on_body_enter(body):
	body.queue_free()
#	print("freeing body: " + body.get_name())
