extends KinematicBody2D

signal gotcha_steve

var velocity = Vector2()
export var direction = -1
export var detect_cliffs =  true

var speed :int = 75
onready var enemy :AnimatedSprite  = get_node("EnemySprite")

func _ready():
	if direction == -1:
		enemy.flip_h = false
	else:
		enemy.flip_h = true
	$floor_checker.position.x = $CollisionShape2D.shape.get_extents().x * direction
	$floor_checker.enabled = detect_cliffs
	if detect_cliffs:
		set_modulate( Color(1.5,0.3,0.5))
	
func _physics_process(delta):
	if is_on_wall() or not $floor_checker.is_colliding() and detect_cliffs and is_on_floor():
		direction = direction * -1
		enemy.flip_h = not enemy.flip_h
		$floor_checker.position.x = $CollisionShape2D.shape.get_extents().x * direction
		
		
	velocity.y += 20
	velocity.x = speed * direction
	move_and_slide(velocity, Vector2.UP)






func _on_Area2D_body_entered(body):
	if(body.get_name()=="steve"):
		enemy.play("squash")
		speed = 0
		$topchecker.set_collision_layer_bit(4,false)
		$topchecker.set_collision_mask_bit(0, false)
		$sidechecker.set_collision_layer_bit(4,false)
		$sidechecker.set_collision_mask_bit(0,false)
		body.bounce()
		$Timer.start()
		
		
	


func _on_sidechecker_body_entered(body):
	if(body.get_name()=="steve"):
		# get_tree().change_scene("res://Level1.tscn")
		print("steve is dead")
		body.ouch(position.x)
		emit_signal("gotcha_steve")
		


func _on_Timer_timeout():
	queue_free()



