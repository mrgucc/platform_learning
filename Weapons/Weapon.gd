extends Area2D
class_name Weapon
@export var damage : int
@export var player : Player
@export var hit_box : WeaponCollision

func _ready():
	player.connect("direction_change", _on_direction_change)

func _on_direction_change(facing_right : bool):
	if (facing_right):
		hit_box.position = hit_box.right_position
	else:
		hit_box.position = hit_box.left_position
	pass
