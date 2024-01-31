extends "res://Character/Player/State.gd"

@export var ground_state : State
@export var jump_velocity = -350
@export var jump_anim_name : String = "jump"

func state_process(delta):
	if(player.is_on_floor()):
		playback.travel("move")
		next_state = ground_state
	elif(player.velocity.y > 0):
		playback.travel("land")

func _on_animation_tree_animation_finished(anim_name):
	if (anim_name == jump_anim_name):
		playback.travel("land")
