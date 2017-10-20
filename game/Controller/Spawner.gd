extends Node

export(PackedScene) var lion_scene
export(NodePath) var lions_parent_path = @"."
onready var lions_parent = get_node(lions_parent_path)

onready var timer = get_node("Timer")
var enemy_count

func start_wave(enemy_count, spawn_interval):
	self.enemy_count = enemy_count
	print("interval: " + str(spawn_interval))
	timer.set_wait_time(spawn_interval)
	timer.start()

func spawn_lion():
	var lion = lion_scene.instance()
	lion.get_node("Lion").connect("lion_dead", get_parent(), "on_lion_dead")
	lions_parent.add_child(lion)
	
	enemy_count -= 1
	if enemy_count == 0:
		timer.stop()
