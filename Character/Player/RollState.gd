extends "res://Character/Player/State.gd"

@export var standing_collision = CollisionShape2D
@export var rolling_collision = CollisionShape2D
@export var roll_speed = 300
@export var state_machine = PlayerStateMachine

@export var roll_animation_name : String = "roll"
@export var ground_state : State

func on_enter():
	player.connect("characters_direction", execute_roll)

func execute_roll(facing_right: bool):
	standing_collision.disabled = true
	rolling_collision.disabled = false
	
	var direction = 1 if facing_right else -1
	player.velocity.x = direction * roll_speed
	
	playback.travel("roll")
	player.disconnect("characters_direction", execute_roll)

func _on_animation_tree_animation_finished(anim_name):
	if (anim_name == "roll"):
		standing_collision.disabled = false
		rolling_collision.disabled = true
		next_state = ground_state
