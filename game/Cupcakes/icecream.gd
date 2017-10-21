extends "cupcake.gd"

func hit(lion):
	lion.get_node("Freeze").set_enabled(true)
	.hit(lion)
