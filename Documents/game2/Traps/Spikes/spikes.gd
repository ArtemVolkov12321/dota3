extends Node2D



func _on_area_2d_player_entered(body: Node2D) -> void:
	if body.name == "Player":
		GlobalVars.health -= 20
		print(GlobalVars.health)
		body.on_death()
