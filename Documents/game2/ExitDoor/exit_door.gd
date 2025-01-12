extends Node2D

@export var needs_key : bool = false
@export var next_scene : String


func _on_go_to_next_scene_body_entered(body: Node2D) -> void:
	if body.name != "Player":
		return
	if needs_key and not body.has_key:
		return
	GlobalVars.save_game()
	GlobalVars.last_level += 1
	if next_scene:
		GlobalVars.health = 100
		get_tree().change_scene_to_file(next_scene)
	else:
		get_tree().change_scene_to_file(GlobalVars.get_level_path(GlobalVars.last_level))
