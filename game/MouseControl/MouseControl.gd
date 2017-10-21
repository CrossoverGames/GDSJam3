extends Node2D

export(NodePath) var towers_interface_path = @""

var pressed = false
var evpos
var object_clicked
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

	if ev.type == InputEvent.MOUSE_MOTION:
		if pressed and moving_tower:
			#evpos = ev.global_pos
			moving_tower.set_global_pos(get_global_mouse_pos())

func tower_button_pressed(button):
	pressed = true
	if button.type == Globals.get("Towers/FirstTower"):
		create_new_tower("res://Unicorns/Unicorn.tscn")
		
func create_new_tower(path):
	var newtower = load(path)
	var tower = newtower.instance()
	get_parent().call_deferred("add_child", tower)
	moving_tower = tower