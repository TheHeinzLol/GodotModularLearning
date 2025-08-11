class_name StandUpCheckComponent
extends Node

func is_stand_up_possible(character: CharacterBody3D, head_position: float = 1.6):
	if !character.raycast.is_colliding(): 
		character.collision_shape_standing.disabled = false
		character.collision_shape_crouching.disabled = true
		character.head.position.y = head_position
		character.is_crouching = false
