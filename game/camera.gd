extends Camera2D

export(float) var speed = 10

var offset = 0

func _ready():
	set_fixed_process(true)
	
func _fixed_process(delta):
	print(offset)
	if offset:
		var offset_now = get_offset()
		set_offset(Vector2(offset_now.x + offset, offset_now.y))

func _on_move_left_mouse_enter():
	offset = speed

func _on_move_left_mouse_exit():
	offset = 10

func _on_move_right_mouse_enter():
	offset = -speed

func _on_move_right_mouse_exit():
	offset = 10
