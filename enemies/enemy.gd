extends CharacterBody2D
class_name Enemy

@export var scarysound: AudioStream
@export var hurtsound: AudioStream

@onready var player = get_tree().get_root().get_node("Main/Pump")
@onready var anims = $"AnimationPlayer"
@onready var shine = $"Shine"
var enemyname
# Stats [Health, Damage, Speed, Knockback]
var stats : Array = [80, 30, 40, 10]
var is_golden = false

func _ready():
	match enemyname:
		"Enemy1": #Ghost
			if is_golden:
				stats = [90, 40, 50, 5]
			else: # Normal
				stats = [50, 20, 30, 10]
		"Enemy2": #Bat
			if is_golden:
				stats = [60, 20, 80, 10]
			else: # Normal
				stats = [30, 10, 40, 20]
	if is_golden == true:
		Sounds._play_sound(scarysound)
		shine.show()
	else:
		shine.hide()

func damage(amount):
	anims.play("hurt")
	Sounds._play_sound(hurtsound)
	stats[0] -= amount
	global_position -= (player.global_position - global_position).normalized() * stats[3]

func _physics_process(delta):
	if stats[0] <= 0:
		Global.totalenemieskilled += 1
		if is_instance_valid(self):
			queue_free()

	global_position += (player.global_position - global_position).normalized() * (stats[2] * delta)
	move_and_slide()
