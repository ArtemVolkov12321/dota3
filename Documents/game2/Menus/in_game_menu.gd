extends Node

@onready var score = $HBoxContainer/MarginContainer2/Score
@onready var hi_score = $HBoxContainer/MarginContainer3/HiScore
@onready var health = $HBoxContainer/HP

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		if not $ConfirmationToMenu.visible:
			show_confirmation_menu()
		else:
			hide_confirmation_menu()
			
	if not score or not hi_score:
		return
	score.text ="ОЧКИ: " + str( GlobalVars.score)
	hi_score.text ="РЕКОРД: " + str(GlobalVars.hi_score)
	health.text = "HP: " + str(GlobalVars.health)

func show_confirmation_menu():
	$HBoxContainer/MarginContainer/ButtonToMenu.disabled = true
	$ConfirmationToMenu.show()
	get_tree().paused = true
	
func hide_confirmation_menu():
	$ConfirmationToMenu.hide()
	$HBoxContainer/MarginContainer/ButtonToMenu.disabled = false
	get_tree().paused = false

func _on_button_to_menu_pressed() -> void:
	show_confirmation_menu()

func _on_button_no_pressed() -> void:
	hide_confirmation_menu()

func _on_button_yes_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Menus/main_menu.tscn")
