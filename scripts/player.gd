extends CharacterBody2D

const SPEED = 300.0

var initial_pos : Vector2

func _ready() -> void:
	initial_pos = position

func _physics_process(delta: float) -> void:
	# Get the input direction and handle the movement/deceleration.
	var direction := Input.get_axis("move_left", "move_right")
	velocity.x = direction * SPEED
	
	# Block vertical movement
	velocity.y = 0

	move_and_slide()
	
	# Resets vertical position to avoid inconsistencies 
	# between Ball's apply_central_impulse and CharacterBody2d.
	position.y = initial_pos.y
