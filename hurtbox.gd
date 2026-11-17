extends Area2D
class_name Hurtbox

func _init():
	collision_layer = 0
	collision_mask = 32

func _ready():
	self.area_entered.connect(_on_area_entered)

func _on_area_entered(hitbox: Hitbox):
	if hitbox == null:
		return
	
	if owner.has_method("damage"):
		owner.damage(hitbox.damage)
