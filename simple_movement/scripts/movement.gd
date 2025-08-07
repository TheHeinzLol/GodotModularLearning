class_name MovementComponent
extends Node
var direction : Vector3 = Vector3.ZERO
var input_dir := Vector2.ZERO

func get_velocity(speed: float, character: CharacterBody3D, delta: float, speed_lerp: float = 0.0) -> Vector3:
	var velocity := character.velocity
	input_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	direction = lerp(direction,
					 character.transform.basis * Vector3(input_dir.x, 0, input_dir.y).normalized(), 
					delta * speed_lerp)
	if direction:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed 
	else:
		velocity.x = 0
		velocity.z = 0
	return velocity
