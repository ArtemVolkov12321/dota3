extends Node
 
var score : int
var hi_score : int

var config
var path_to_save_file := "user://game.cfg"
var section_name := "game"

var starts_n = 0
var death_n : int = 0
var kills_n := 0
var saves_n := 0
var player1_name : String

var last_level : int
var max_health = 100
var health = max_health
func _ready() -> void:
	#print("globals.gd автоматически загружен!")
	load_game()
	starts_n += 1

func save_game() -> void:
	saves_n += 1
	config.set_value(section_name, "player_name", player1_name)
	config.set_value(section_name, "starts_n", starts_n)
	config.set_value(section_name, "death_n", death_n)
	config.set_value(section_name, "kills_n", kills_n)
	config.set_value(section_name, "saves_n", saves_n)
	config.set_value(section_name, "last_level", last_level)
	config.set_value(section_name, "score", score)
	config.set_value(section_name, "hi_score", hi_score)
	config.set_value(section_name, "health", health)
	config.save(path_to_save_file)
	
func load_game() -> void:
	config = ConfigFile.new()
	config.load(path_to_save_file)
	player1_name = config.get_value(section_name, "player_name", "Бобик")
	starts_n = config.get_value(section_name, "starts_n",0)
	death_n = config.get_value(section_name, "death_n",0)
	kills_n = config.get_value(section_name, "kills_n",0)
	saves_n = config.get_value(section_name, "saves_n",0)
	score = config.get_value(section_name, "score",0)
	hi_score = config.get_value(section_name, "hi_score",0)
	health = config.get_value(section_name, "health",0)
	if config.get_value(section_name, "last_level", 1) is String:
		last_level = 1
	else:
		last_level = config.get_value(section_name, "last_level", 1)
	
func get_level_path(n : int):
	return "res://Levels/level"+str(n)+".tscn"
