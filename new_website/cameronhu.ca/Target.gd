extends Node2D




func _on_Area2D_area_entered(area):
	if "Hitbox" in area.name:
		print("Target hit")
		visible = false
