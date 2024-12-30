extends Area2D

enum item_type {ITEM_FRUIT, ITEM_KEY, ITEM_D_JUMP, ITEM_BONUS, ITEM_HEALTH}
@export var type : item_type

@export var points : int = 1
var is_picked : bool = false

func _ready() -> void:
	pass # Replace with function body.


func _process(_delta: float) -> void:
	pass

func on_pickup(body):
	if is_picked:
		return
	is_picked = true
	var tween1 = get_tree().create_tween().set_parallel(true)
	tween1.tween_property($".", "position:y", position.y - 20,1)
	tween1.tween_property($AnimatedSprite2D, "self_modulate:a",0,1)
	

	GlobalVars.score += points
	if(GlobalVars.score > GlobalVars.hi_score):
		GlobalVars.hi_score = GlobalVars.score
		$OnRecord.play()
		await $OnRecord.finished
	else:
		$Sound.play()
		await $Sound.finished
	await tween1.finished

	match type:
		item_type.ITEM_FRUIT:
			pass
		item_type.ITEM_KEY:
			body.has_key = true
			#print_debug("Взял ключ")
		item_type.ITEM_BONUS:
			pass
		item_type.ITEM_D_JUMP:
			body.has_double_jump = true
		item_type.ITEM_HEALTH:
			GlobalVars.health += 40
			print("HP:",GlobalVars.health)
	#get_tree().queue_delete(self)
	queue_free()
