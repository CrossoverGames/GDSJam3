extends Area2D

signal end_game

func _on_end_game_body_enter( body ):
	if(body.is_in_group("lion")):
		emit_signal("end_game")
