extends Node

var totalenemieskilled = 0
var totalgraves = 66
var timespent = 0

func _ready():
	pass

func _process(delta):
	if totalenemieskilled >= totalgraves:
		get_tree().change_scene_to_file("res://menu/success.tscn")
