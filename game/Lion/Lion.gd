extends KinematicBody2D

export(int) var hp = 100
export(int) var speed = 40
export(int) var reward = 10

var path_follow
var lifebar

signal lion_dead(reward)

func _ready():
	path_follow = get_parent()
	lifebar = get_node("LifeBar")
	
	lifebar.update_max_hp(hp)
	
	set_fixed_process(true)

func _fixed_process(delta):
	var offset = path_follow.get_offset()
	path_follow.set_offset(offset + (speed * delta))
	
func hit(value):
	if hp > 0:
		hp -= value
		lifebar.set_value(hp)
	else:
		emit_signal("lion_dead", reward)
		queue_free()
		
	