extends CanvasLayer

func _ready():
	get_node("retry_button").connect("pressed", self, "load_scene")
	get_node("quit_button").connect("pressed", get_tree(), "quit")

func load_scene():
	get_tree().change_scene("res://Stage/stage.tscn")
