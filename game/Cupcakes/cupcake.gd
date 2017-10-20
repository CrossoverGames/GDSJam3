extends KinematicBody2D

export(float) var max_speed = 50.0
export(float, EASE) var speed_transition = 2

var target
var speed
var timer

func set_target(lion):
	target = lion

func _ready():
	set_process(true)
	timer = 0

func _process(delta):
	if target == null: return
	
	speed = max_speed * ease(timer, speed_transition)
	timer += delta
	
	var direction = (target.get_global_pos() - self.get_global_pos()).normalized()
	self.move(direction * speed * delta)
