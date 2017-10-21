extends KinematicBody2D

export(float) var damage = 30.0
export(float) var max_speed = 150.0
export(float, EASE) var speed_transition = 2

var target_pos
var direction

var speed
var timer

func set_target(lion):
	target_pos = lion.get_global_pos()

func _ready():
	set_process(true)
	direction = (target_pos - get_global_pos()).normalized()
	timer = 0

func _process(delta):
	if target_pos == null: return
	
	speed = max_speed * ease(timer, speed_transition)
	timer += delta
	
	self.move(direction * speed * delta)
	
	if is_colliding():
		if get_collider().is_in_group("lion"):
			get_collider().hit(damage)
			queue_free()
