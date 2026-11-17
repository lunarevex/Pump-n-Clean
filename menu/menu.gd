extends CanvasLayer

@export var menusound: AudioStream
@export var gameplaysound: AudioStream
@onready var playbutton = $"Buttons/VBoxContainer/Play"
@onready var optionsbutton = $"Buttons/VBoxContainer/Options"
@onready var quitbutton = $"Buttons/VBoxContainer/Quit"


func _enter_tree():
	Sounds._stop_sound()
	Sounds._play_sound(menusound)

func _process(delta):
	pass

func _on_play_pressed():
	Sounds._stop_sound()
	get_tree().change_scene_to_file("res://main.tscn")

func _on_options_pressed():
	pass # Replace with function body.

func _on_quit_pressed():
	get_tree().quit()
