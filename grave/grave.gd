extends StaticBody2D

@export var hurtsound: AudioStream

@onready var openlabel = $"Control/Open"
@onready var areacol = $"GraveArea/CollisionShape2D"
@onready var sprite = $"Sprite2D"
@onready var spawnlocation = $"Spawnloc"
@onready var shine = $"Shine"
var states = ["closed", "open"]
var type = ["normal", "normal", "normal", "normal", "normal", "normal", "normal", "normal", "normal", "golden"]
var goldenrng = ["nah", "yuh", "nah"]
@export var enemies: Array[Resource]
var currentstate
var currenttype


func _ready():
	randomize()
	currenttype = type.pick_random()
	openlabel.hide()
	currentstate = states[0]

	currenttype = type.pick_random()
	match currenttype:
		"normal":
			shine.hide()
		"golden":
			set_modulate(Color(1,1,1,1))
			shine.show()

func _on_grave_area_area_entered(area):
	if area.name == "Detect":
		openlabel.show()

func _on_grave_area_area_exited(area):
	if area.name == "Detect":
		openlabel.hide()

func _process(delta):
	if openlabel.visible == true:
		if Input.is_action_just_pressed("e") and currentstate != "open":
			areacol.disabled = true
			currentstate = states[1]
			openlabel.hide()
			
			_spawn_enemy()

	match currentstate:
		"closed":
			sprite.frame = 3
		"open":
			sprite.frame = 11

func _spawn_enemy():
	var enemy = enemies.pick_random().instantiate()
	enemy.enemyname = enemy.get_name()
	if currenttype == "golden":
		enemy.is_golden = true
		var goldenmode = goldenrng.pick_random()
		if goldenmode == "yuh":
			get_tree().get_root().get_node("Main/Pump").goldenmode = true
	else:
		Sounds._play_sound(hurtsound)
	get_tree().get_root().get_node("Main/Enemies").add_child(enemy)
	enemy.global_position = spawnlocation.global_position
	enemy.get_node("AnimationPlayer").play("spawn")
	enemy = null
