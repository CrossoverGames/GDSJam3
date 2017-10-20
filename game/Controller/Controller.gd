extends Node

export(float) var money = 0.0
export(int, 1, 10000) var wave = 1

var lions_alive = 0

func get_enemy_count():
	return 5 + 4 * wave

func get_wave_interval():
	return 20.0 + 10.0 * wave

func get_spawn_interval():
	return get_enemy_count() / (5.0 + 2.0 * wave)

func get_wave_reward():
	return 10.0 * wave

func advance_wave():
	wave += 1

func start_wave():
	lions_alive = get_enemy_count()
	get_node("Spawner").start_wave(lions_alive, get_spawn_interval())

func on_lion_dead(reward):
	lions_alive -= 1
	money += reward
	
	if lions_alive == 0:
		advance_wave()
		money += get_wave_reward()