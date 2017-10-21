extends KinematicBody2D

export(int) var hp = 100
export(int) var speed = 40
export(int) var reward = 10
export(float) var damage = 10
export(float) var roar_interval = 1.5

onready var path_follow = get_parent()
onready var lifebar = get_node("LifeBar")
onready var roar_timer = get_node("RoarTimer")

signal lion_dead(reward)

func _ready():
	lifebar.update_max_hp(hp)
	lifebar.set_value(hp)
	set_fixed_process(true)

func _fixed_process(delta):
	var offset = path_follow.get_offset()
	path_follow.set_offset(offset + (speed * delta))
	
func hit(value):
	hp -= value
	if hp <= 0:
		hp = 0
		emit_signal("lion_dead", reward)
		#queue_free()
		remove_from_group("lion")
		get_node("AnimatedSprite").play("rip")
		get_node("CollisionShape2D").queue_free()
		get_node("LifeBar").queue_free()
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