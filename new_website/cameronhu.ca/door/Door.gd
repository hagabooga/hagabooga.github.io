extends Area2D

export(String) var link


func _process(delta):
	if Input.is_action_just_pressed("ui_up") and len(get_overlapping_bodies()) > 1 and $Timer.is_stopped():
		OS.shell_open(link)
		$Timer.start()


func _on_WalkIn_body_entered(body):
	if body is Player:
		print("asd")
		$AnimatedSprite.play("default")
		$WalkIn.queue_free()
