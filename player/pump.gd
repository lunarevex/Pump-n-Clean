extends CharacterBody2D
class_name Player

@export var hitsound : AudioStream
@export var hurtsound : AudioStream

@onready var weapon1 = preload("res://weapons/weapon1.tscn")
@onready var weapon2 = preload("res://weapons/weapon2.tscn")
@onready var inventory = [weapon1]
@onready var pivot = $"Pivot"
@onready var hand = $"Pivot/Hand"
@onready var anims = $"AnimationPlayer"
var weaponhitbox
var currentweapon
var weaponnumber
var weaponname
var knockback = 2000

# Stats [Health, Damage, Speed]
var stats = [100, 15, 100]
var currenthealth = 100
var maxhealth = 100

@onready var goldentimer = $"GoldenTimer"
var goldenmode = false

func _ready():
	currentweapon = inventory[0]
	_weapon_init(currentweapon)

func _physics_process(delta):
	var input = Vector2(Input.get_axis("left","right"), Input.get_axis("up","down")).normalized()
	velocity = input * stats[2]
	move_and_slide()

	var mouseposition = Vector2(get_global_mouse_position() - global_position).normalized()
	pivot.look_at(get_global_mouse_position())

	if weaponnumber >= inventory.size() - 1:
		weaponnumber = -1
	if Input.is_action_just_pressed("leftclick") and !anims.is_playing():
		anims.play("sweep")
		Sounds._play_sound(hitsound)
	if Input.is_action_just_pressed("tab") and !anims.is_playing():
		_weapon_switch(inventory[weaponnumber + 1])

	if currenthealth > maxhealth:
		currenthealth = maxhealth
	elif currenthealth <= 0:
		Sounds._stop_sound()
		get_tree().change_scene_to_file("res://menu/game_over.tscn")
	else:
		currenthealth += 0.5 * delta

	if !anims.is_playing() and weaponhitbox.get_node("CollisionShape2D").disabled == false:
		weaponhitbox.get_node("CollisionShape2D").disabled = true
		print("HELLO")

	if goldenmode == true and inventory.find(weapon2, 0) == -1 and !anims.is_playing():
		_golden_mode()
		goldenmode = false

	if Input.is_action_just_pressed("escape"):
		Sounds._stop_sound()
		get_tree().change_scene_to_file("res://menu/menu.tscn")

func _weapon_init(weapon):
	var weaponinstance = weapon.instantiate()
	weaponhitbox = weaponinstance.get_child(1)
	weaponhitbox.get_node("CollisionShape2D").disabled = true
	weaponnumber = weaponinstance.name
	weaponname = weaponinstance.name
	weaponnumber = weaponnumber.replace('weapon', '')
	weaponnumber = int(weaponnumber) - 1

	match weaponname:
		"weapon1":
			stats = [100, 15, 100]
			maxhealth = stats[0]
			weaponhitbox.damage = stats[1]
		"weapon2":
			stats = [120, 20, 150]
			maxhealth = stats[0]
			weaponhitbox.damage = stats[1]

	hand.add_child(weaponinstance)

func _weapon_switch(weapon):
	hand.get_child(0).queue_free()
	_weapon_init(weapon)

func _disable_hitbox(value):
	if weaponhitbox == null:
		return
	
	weaponhitbox.get_node("CollisionShape2D").disabled = !weaponhitbox.get_node("CollisionShape2D").disabled
	return weaponhitbox.get_node("CollisionShape2D").disabled

func _on_hurt_area_body_entered(body):
	if body.is_in_group("Enemies"):
		anims.play("hurt")
		Sounds._play_sound(hurtsound)
		currenthealth -= body.stats[1]
		_knock_player(body)

func _knock_player(enemy):
	var knockbackdir = (global_position - enemy.global_position).normalized() * knockback
	velocity = knockbackdir
	move_and_slide()

func _golden_mode():
	inventory.append(weapon2)
	_weapon_switch(inventory[1])
	goldentimer.start()
	# for future update xDDD
	#inventory.insert(inventory.size(), weapon2)

func _on_golden_timer_timeout():
	inventory.erase(weapon2)
	_weapon_switch(inventory[0])

