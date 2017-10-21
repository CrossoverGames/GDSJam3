extends Node2D

export(NodePath) var towers_interface_path = @""
export(NodePath) var controller_path = @""

export(PackedScene) var unicorn_1
export(PackedScene) var unicorn_2
export(PackedScene) var unicorn_3

export(FloatArray) var prices

var pressed = false
var towers_interface
var moving_tower
var towers = []

signal mouse_clicked(mouse_pos)

func _ready():
	towers_interface = get_node(towers_interface_path)
	towers = get_tree().get_nodes_in_group("tower_button")
	for button in towers:
		button.connect("pressed", self, "tower_button_pressed", [button])
	set_process_input(true)

func _input(ev):
	if ev.type == InputEvent.MOUSE_BUTTON and ev.button_index == BUTTON_LEFT:
		pressed = ev.pressed
		emit_signal("mouse_clicked", ev.global_pos)
		if not pressed and moving_tower:
			moving_tower.set_active(true)
			moving_tower = null

	if ev.type == InputEvent.MOUSE_MOTION:
		if pressed and moving_tower:
			moving_tower.set_global_pos(get_global_mouse_pos())

func tower_button_pressed(button):
	pressed = true
	if button.type == Globals.get("Towers/FirstTower"):
		if get_node(controller_path).money >= prices[0]:
			get_node(controller_path).money -= prices[0]
			create_new_tower(unicorn_1)
	elif button.type == Globals.get("Towers/Second Tower"):
		if get_node(controller_path).money >= prices[1]:
			get_node(controller_path).money -= prices[1]
			create_new_tower(unicorn_2)
	elif button.type == Globals.get("Towers/Third Tower"):
		if get_node(controller_path).money >= prices[2]:
			get_node(controller_path).money -= prices[2]
			create_new_tower(unicorn_3)
		
func create_new_tower(scene):
	var tower = scene.instance()
	get_node("../..").call_deferred("add_child", tower)
	moving_tower = tower
	moving_tower.set_active(false)