class_name MovementComponent
extends Node
var direction : Vector3 = Vector3.ZERO

func get_velocity(character: CharacterBody3D, input_dir: Vector2, speed: float, delta: float, speed_lerp: float = 0.0) -> Vector3:
	var velocity := character.velocity
	#direction = lerp(direction,
					 #character.transform.basis * Vector3(input_dir.x, character.velocity.y, input_dir.y).normalized(), 
					#delta * speed_lerp)
	direction = character.transform.basis * Vector3(input_dir.x, 0, input_dir.y).normalized()
	if direction:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed 
	else:
		velocity.x = 0
		velocity.z = 0
	return velocity
