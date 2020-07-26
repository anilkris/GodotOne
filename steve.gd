extends KinematicBody2D

var velocity :Vector2 = Vector2()
const SPEED :int = 80
const JUMPFORCE :int = 700
const GRAVITY :int = 800
var coins: int = 0


onready var sprite :AnimatedSprite  = get_node("Sprite")

func _physics_process(delta):
		
	if Input.is_action_pressed("move_right"):
		velocity.x += SPEED
		sprite.play("walk")
	elif Input.is_action_pressed("move_left"):
		velocity.x -= SPEED
		sprite.play("walk")
	else:
		sprite.play("idle")
		
	velocity = move_and_slide(velocity,Vector2.UP)
	velocity.y +=  GRAVITY*delta
	
	
	if not is_on_floor():
		sprite.play("air")
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y -= JUMPFORCE
	
	
	
	if velocity.x < 0 :
		sprite.flip_h = true
	elif velocity.x > 0 :
		sprite.flip_h = false
	
	
	velocity.x = lerp(velocity.x,0,0.2)



func _on_FallZone_body_entered(body):
	get_tree().change_scene("res://Level1.tscn")
	
func bounce():
	velocity.y -=400

	
func ouch(var enemy_posx):
	print("ouch", enemy_posx)
	set_modulate( Color(1,0.3,0.3,0.3))
	if(position.x < enemy_posx):
		velocity.x -= 800
	elif (position.x > enemy_posx):
		velocity.x += 800
	
	velocity.y -= 500
	
	Input.action_release("jump")
	Input.action_release("move_left")
	Input.action_release("move_right")
	$Timer.start();

	



func add_coins():
	coins = coins + 1
	print("Coins", coins)


func _on_Timer_timeout():
	set_modulate( Color(1,1,1,1))
	
