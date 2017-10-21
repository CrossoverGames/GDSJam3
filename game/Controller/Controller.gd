extends Node

export(float) var money = 50.0
export(int, 1, 10000) var wave = 1

var lions_alive = 0

func _ready():
	start_wait_time()

func get_enemy_count():
	return 5 + 4 * wave

func get_wave_interval():
	return 5.0 + 5.0 * wave

func get_spawn_interval():
	return get_enemy_count() / (5.0 + 2.0 * wave)

func get_wave_reward():
	return 10.0 * wave

func advance_wave():
	wave += 1

func start_wave():
	lions_alive = get_enemy_count()
	get_node("Spawner").start_wave(lions_alive, get_spawn_interval())

func start_wait_time():
	var timer = get_node("AdminTimer")
	timer.set_wait_time(get_wave_interval())
	timer.start()

func on_lion_dead(reward):
	lions_alive -= 1
	money += reward
	
	if lions_alive == 0:
		advance_wave()
		money += get_wave_reward()
		start_wait_time()