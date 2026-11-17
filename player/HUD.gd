extends CanvasLayer

@export var player: Player
@onready var progressbar = $"TextureProgressBar"
@onready var label = $"Label"
@onready var completion = $"Completion"
@onready var completion2 = $"CompletionText2"

func _physics_process(delta):
	_update()

func _update():
	progressbar.value = player.currenthealth * 100 / player.maxhealth
	label.text = str(progressbar.value) + "%"

	completion.value = Global.totalenemieskilled * 100 / Global.totalgraves
	completion2.text = "Time (seconds): " + str(Global.timespent)
