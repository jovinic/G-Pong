extends RigidBody2D

@export var force : float = 50
@export var force_modifier : float = 1.20

@export var max_ball_speed : float = 300
@export var min_ball_speed : float = 150

func _ready() -> void:
	# Applies a random initial direction
	var velocity = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()
	print(velocity * force)
	apply_central_impulse(velocity * force)

func _physics_process(delta: float) -> void:
	# Adds a minimum and maximum spell for the ball
	if abs(linear_velocity.y) > max_ball_speed:
		linear_velocity.y = max_ball_speed if linear_velocity.y > 0 else -max_ball_speed
	elif abs(linear_velocity.y) < min_ball_speed:
		linear_velocity.y = min_ball_speed if linear_velocity.y > 0 else -min_ball_speed

	# Limits how much a character can change the ball's trajectory
	if abs(linear_velocity.x) > max_ball_speed:
		linear_velocity.x = max_ball_speed if linear_velocity.x > 0 else -max_ball_speed

func _on_body_entered(body: Node) -> void:
	#print(body)
	if body.is_in_group("Character"):
		# Defines rebound force through looking at collision normal
		var normal = (position - body.position).normalized()
		var rebound_force = normal * force * force_modifier
		print(rebound_force)

		# Applies rebound force
		apply_central_impulse(rebound_force)
