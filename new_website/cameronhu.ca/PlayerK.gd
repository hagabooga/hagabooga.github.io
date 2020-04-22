extends KinematicBody2D
class_name Player

export(float) var speed = 300
export(float) var jump_speed = -500
export(float) var gravity = 2000

var velocity = Vector2.ZERO


func _ready():
	Engine.set_iterations_per_second(150)
	Engine.set_target_fps(Engine.get_iterations_per_second())

var friction = 0.1
var acceleration = 0.08

func get_input():
	var input_dir = 0
	if Input.is_action_pressed("ui_right"):
		input_dir += 1
	if Input.is_action_pressed("ui_left"):
		input_dir -= 1
	if input_dir != 0:
		# accelerate when there's input
		velocity.x = lerp(velocity.x, input_dir * speed, acceleration)
	else:
		# slow down when there's no input
		velocity.x = lerp(velocity.x, 0, friction)

func _physics_process(delta):
#	if $Sprite.animation == "attack":
#		return
	get_input()
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2.UP)
	velocity = Vector2(int(velocity.x), int(velocity.y))

	if Input.is_action_just_pressed("ui_select"):
		if is_on_floor():
			velocity.y = jump_speed
	if Input.is_action_just_pressed("left_ctrl"):
		$Sprite.play("attack")
	if $Sprite.animation == "attack":
		return
	
	if velocity.y < 0:
		$Sprite.play("jump_up")
	elif velocity.y > 0:
		$Sprite.play("jump_down")
	elif velocity.x != 0 and velocity.y == 0:
		$Sprite.play("walk")
	else:
		$Sprite.play("idle") 
	if velocity.x != 0:
		$Sprite.flip_h = velocity.x < 0
#	print(velocity)


func _on_Sprite_animation_finished():
	if $Sprite.animation == "attack":
		$Sprite.play("idle")


func _on_Sprite_frame_changed():
	if $Sprite.animation == "attack" and $Sprite.frame in [2,3]:
		if $Sprite.flip_h:
			$HitboxLeft/CollisionShape2D.disabled = false
		else:
			$HitboxRight/CollisionShape2D.disabled = false
	else:
		$HitboxRight/CollisionShape2D.disabled = true
		$HitboxLeft/CollisionShape2D.disabled = true
