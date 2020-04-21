extends CanvasLayer


func _on_NumberLink_gui_input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
		OS.shell_open("tel:+7788557829")


func _on_EmailLink_gui_input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
		OS.shell_open("mailto:ckhu@sfu.ca")



func _on_GithubLink_gui_input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
		OS.shell_open("https://github.com/hagabooga")



func _on_LinkedinLink_gui_input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
		OS.shell_open("https://www.linkedin.com/in/cameron-hu-253944171/")
