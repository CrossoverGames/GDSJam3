extends StaticBody2D

export(float) var health = 100.0

export(PackedScene) var cupcake_scene
export(float) var interval = 1.0

onready var lifebar = get_node("LifeBar")

var shoot_timer
var lions_in_range = []

var ripped = false

func _ready():
	var reach = get_node("range")
	reach.connect("body_enter", self, "lion_enter")
	reach.connect("body_exit", self, "lion_exit")
	
	lifebar.update_max_hp(health)
	
	shoot_timer = Timer.new()
	shoot_timer.set_name("shoot_timer")
	shoot_timer.set_autostart(false)
	shoot_timer.set_one_shot(false)
	shoot_timer.set_wait_time(interval)
	shoot_timer.set_timer_process_mode(Timer.TIMER_PROCESS_IDLE)
	shoot_timer.connect("timeout", self, "shoot_cupcake")
	self.add_child(shoot_timer)

func lion_enter(lion):
	if not lion.is_in_group("lion"): return
	lions_in_range.append(lion)
	
	if lions_in_range.size() == 1:
		shoot_cupcake()
		shoot_timer.start()

func lion_exit(lion):
	if lions_in_range.has(lion):
		lions_in_range.erase(lion)

func shoot_cupcake():
	if ripped or lions_in_range.empty():
		shoot_timer.stop()
		return
	
	var cupcake = cupcake_scene.instance()
	cupcake.set_target(lions_in_range[0])
	cupcake.set_pos(get_node("cupcake_spawn").get_pos())
	self.add_child(cupcake)

func scare(points):
	health -= points
	if health <= 0:
		health = 0
		rip()
	lifebar.set_value(health)

func rip():
	ripped = true
	shoot_timer.stop()
#	get_node("sprite").play("rip")
	queue_free()
