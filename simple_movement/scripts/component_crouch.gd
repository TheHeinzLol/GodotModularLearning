class_name CrouchComponent
extends Node

func crouch(character: CharacterBody3D, crouching_depth: float, delta: float):
	character.head.position.y = lerp(character.head.position.y,
									 crouching_depth,
									 delta * character.speed_lerp)
	character.collision_shape_standing.disabled = true
	character.collision_shape_crouching.disabled = false
