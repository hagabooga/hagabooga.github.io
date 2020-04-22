extends Node


var time = 0


func _ready():
	if OS.get_model_name() != "GenericDevice":
		$Instructions/Label6.text += OS.get_model_name()
		$Instructions/Label6.visible = true
		

func _process(delta):
	if time > .3:
		for x in [$Instructions/Node2D/Key,$Instructions/Node2D/Key2,$Instructions/Node2D/Key3,
				$Instructions/Key, $Instructions/Key2]:
			x.frame = (x.frame + 1) % 2
		time = 0
	else:
		time += delta


func _on_Sprite3_animation_finished():
	$Instructions/Sprite3.flip_h = !$Instructions/Sprite3.flip_h




func _on_Button_pressed():
	OS.shell_open("https://cameronhu.ca/")
