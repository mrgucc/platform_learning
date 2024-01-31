extends CharacterBody2D
class_name Player

@export var speed : float = 200.0
@export var roll_state : State
@onready var sprite : Sprite2D = $Sprite2D
@onready var animation_tree : AnimationTree = $AnimationTree
@onready var state_machine : PlayerStateMachine = $PlayerStateMachine


signal characters_direction(facing_right: bool)

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction : Vector2 = Vector2.ZERO


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	move_and_slide()
	update_animation_parameters()
	update_animation_direction()
	update_animation_moving()

func update_animation_parameters():
	animation_tree.set("parameters/move/blend_position", direction.x)

func update_animation_direction():
	if direction.x > 0:
		sprite.flip_h = false
	elif direction.x < 0:
		sprite.flip_h = true
	
	#emit a signal for states to know if the char is facing left or right
	emit_signal("characters_direction", !sprite.flip_h) 

func update_animation_moving():
	direction = Input.get_vector("left", "right", "up", "down")
	if (state_machine.current_state == roll_state):
		return
	if direction.x != 0 && state_machine.check_if_can_move():
		velocity.x = direction.x * speed
		pass
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
	pass
