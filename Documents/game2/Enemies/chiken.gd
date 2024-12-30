extends CharacterBody2D


const SPEED = 30.0
const JUMP_VELOCITY = -400.0
@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
@export var direction := -1
var spawn_position : Vector2
var alive = true

func _ready() -> void:
	velocity = Vector2.ZERO
	spawn_position = position
	#if randf() < 0.5:
		#direction = -1
	#else:
		#direction = 1

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	if is_on_wall():
		direction = -direction
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	update_animation()
	move_and_slide()
	if position.y > 3000:
		on_death()
	
func update_animation():
	if velocity.x < 0:
		anim.flip_h = false
	elif velocity.x > 0:
		anim.flip_h = true
		$Damage.rotation_degrees = 180
	if velocity.x:
		anim.play("Run")
	else:
		anim.play("Idle")


func on_death():
	position = spawn_position
	#self.queue_free()


func _on_damage_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		GlobalVars.health -= 20
		$DamageSound.play()
		await $DamageSound.finished
		#print(GlobalVars.health)
		body.on_death()
		
