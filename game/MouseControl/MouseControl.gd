extends Node2D

var pressed = false
var evpos
var object_clicked
var towers = []

signal mouse_clicked(mouse_pos)

func _ready():	
	set_process_input(true)

func _input(ev):
	if ev.type == InputEvent.MOUSE_BUTTON and ev.button_index == BUTTON_LEFT:
		pressed = ev.pressed
		emit_signal("mouse_clicked", ev.global_pos)

	if ev.type == InputEvent.MOUSE_MOTION:
		if pressed and object_clicked:
			evpos = ev.global_pos
			object_clicked.set_global_pos(evpos)