extends Node

export(bool) var active = false

onready var lion = get_parent()
var original_speed

func set_active(value):
	if active == value: return
	
	active = value
	if active:
		original_speed = lion.speed
		lion.speed = 0.0
	elif original_speed != null:
		lion.speed = original_speed
		original_speed = null
