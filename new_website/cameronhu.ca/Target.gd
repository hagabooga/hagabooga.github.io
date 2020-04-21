extends Node2D


func _on_Area2D_area_entered(area):
	if "Hitbox" in area.name:
		print("Target hit")
		$AudioStreamPlayer2D.play()
		visible = false


func _on_AudioStreamPlayer2D_finished():
	queue_free()
