extends CanvasLayer

func _on_retry_pressed():
	get_tree().change_scene_to_file("res://menu/menu.tscn")

func _enter_tree():
	$"VBoxContainer/Stats1".text = "Total Monsters Killed: " + str(Global.totalenemieskilled)
