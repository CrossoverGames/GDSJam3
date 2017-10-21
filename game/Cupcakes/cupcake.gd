extends KinematicBody2D

export(float) var damage = 30.0
export(float) var angular_speed = 360.0
export(float) var max_speed = 150.0
export(float, EASE) var speed_transition = 2
export(float) var random = 10.0

var target_pos
var direction

var speed
var timer

func set_target(lion):
	target_pos = lion.get_global_pos()

func _ready():
	set_process(true)
	direction = (target_pos - get_global_pos()).normalized()
	direction = direction.rotated(deg2rad(rand_range(-random, random)))
	var rotation = Vector2(0, -1).angle_to(direction)
	set_rot(rotation)
	timer = 0

func _process(delta):
	if target_pos == null: return
	
	speed = max_speed * ease(timer, speed_transition)
	timer += delta
	
	self.move(direction * speed * delta)
	self.rotate(deg2rad(angular_speed) * delta)
	
	if is_colliding():
		var collider = get_collider()
		if collider.is_in_group("lion"):
			hit(collider)

func hit(lion):
	lion.hit(damage)
	queue_free()
