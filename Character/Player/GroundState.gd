extends "res://Character/Player/State.gd"

class_name GroundState

@export var initialization_timer : Timer
@export var roll_state : State
@export var jump_velocity = -350
@export var air_state : State

func state_process(delta):
	if(!player.is_on_floor() && initialization_timer.is_stopped()):
		next_state = air_state

func state_input(event : InputEvent):
	if (event.is_action_pressed("roll")):
		next_state = roll_state
	if (event.is_action_pressed("jump")):
		jump()

func jump():
	player.velocity.y = jump_velocity
	playback.travel("jump")
	next_state = air_state
