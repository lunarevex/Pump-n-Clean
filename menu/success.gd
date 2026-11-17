extends CanvasLayer

func _on_retry_pressed():
	Global.totalenemieskilled = 0
	get_tree().change_scene_to_file("res://menu/menu.tscn")

func _enter_tree():
	$"VBoxContainer/Stats2".text = "TIME SPENT (SECONDS): " + str(Global.timespent)
	$"VBoxContainer/Stats1".text = "Total Monsters Killed: " + str(Global.totalenemieskilled)
