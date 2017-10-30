extends KinematicBody2D

export(int) var hp = 100
export(int) var speed = 40
export(int) var reward = 10
export(float) var damage = 10
export(float) var roar_interval = 1.5

onready var path_follow = get_parent()
onready var lifebar = get_node("LifeBar")
onready var roar_timer = get_node("RoarTimer")
onready var delete_timer = get_node("DeadTimer")

var flipped = false

signal lion_dead(reward)

func _ready():
	lifebar.update_max_hp(hp)
	lifebar.set_value(hp)
	set_fixed_process(true)

func _fixed_process(delta):
	var offset = path_follow.get_offset()
	var last_pos = get_global_pos()
	path_follow.set_offset(offset + (speed * delta))
	var x_direction = get_global_pos().x - last_pos.x
	if x_direction < -1 and not flipped:
		get_node("AnimatedSprite").set_flip_h(true)
		flipped = true
	if x_direction >= -1 and flipped:
		get_node("AnimatedSprite").set_flip_h(true)
		flipped = false
	
func hit(value):
	hp -= value
	if hp <= 0:
		hp = 0
		emit_signal("lion_dead", reward)
		delete_timer.start()
		#queue_free()
		remove_from_group("lion")
		get_node("AnimatedSprite").play("rip")
		get_node("CollisionShape2D").queue_free()
		get_node("LifeBar").queue_free()
		damage = 0
		set_fixed_process(false)
	lifebar.set_value(hp)

func on_body_enter(body):
	if body.is_in_group("unicorn"):
		rawr()
		roar_timer.start()

func on_body_exit(body):
	if is_queued_for_deletion(): return
	if get_node("attack_area").get_overlapping_bodies().empty():
		roar_timer.stop()

func rawr():
	if is_queued_for_deletion(): return
	var targets = get_node("attack_area").get_overlapping_bodies()
	targets += get_node("attack_area").get_overlapping_areas()
	
	for target in targets:
		if target.is_in_group("unicorn"):
			target.scare(damage)
			
func delete():
	queue_free()