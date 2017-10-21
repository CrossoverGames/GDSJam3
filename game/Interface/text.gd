extends Label

var timer
export(NodePath) var controller_path
var controller 

func _ready():
	controller = get_node(controller_path)
	timer = controller.get_node("AdminTimer")
	set_process(true)

func _process(delta):
	var text = "Money: " + str(controller.money)
	text += "\nWave " + str(controller.wave) + ". "
	if timer.get_time_left() == 0.0:
		text += "Remaining enemies: " + str(controller.lions_alive)
	else:
		text += "Next wave in " + str(ceil(timer.get_time_left())) + " s"
	set_text(text)