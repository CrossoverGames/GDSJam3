extends Area2D

func _on_end_game_body_enter( body ):
	if(body.is_in_group("lion")):
		get_tree().change_scene("res://Stage/game_over.tscn")
