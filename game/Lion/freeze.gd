extends Node

export(bool) var enabled = false
export(float, 0.0, 1.0, 0.01) var speed_scale = 0.5

onready var lion = get_parent()
var original_speed

func set_enabled(value):
	if enabled == value: return
	
	enabled = value
	if enabled:
		original_speed = lion.speed
		lion.speed *= speed_scale
		get_node("Timer").start()
	elif original_speed != null:
		lion.speed = original_speed
		original_speed = null
