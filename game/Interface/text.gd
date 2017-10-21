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
	if timer.get_time_left() == 0.0:
		text += "\nRemaining enemies: " + str(controller.lions_alive)
	else:
		text += "\nNext wave in " + str(ceil(timer.get_time_left())) + " s"
	set_text(text)