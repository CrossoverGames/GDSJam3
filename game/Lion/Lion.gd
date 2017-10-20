extends KinematicBody2D

export(int) var hp = 100
export(int) var speed = 40

var path_follow

func _ready():
	path_follow = get_parent()
	set_fixed_process(true)

func _fixed_process(delta):
	var offset = path_follow.get_offset()
	path_follow.set_offset(offset + (speed * delta))