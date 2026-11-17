extends TileMap

@export var gameplaysound1: AudioStream

func _ready():
	Global.totalgraves = get_used_cells(4).size()
	Sounds._play_sound(gameplaysound1)
	get_parent().get_node("Timer").start()

func _exit_tree():
	get_parent().get_node("Timer").stop()

func _on_timer_timeout():
	Global.timespent += 1
