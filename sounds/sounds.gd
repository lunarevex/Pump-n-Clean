extends Node2D

var currentinstance

func _play_sound(stream: AudioStream):
	var instance = AudioStreamPlayer.new()
	instance.stream = stream
	currentinstance = instance
	add_child(instance)
	instance.play()

func _stop_sound():
	if currentinstance == null:
		return
	currentinstance.stop()
