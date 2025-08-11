class_name JumpComponent
extends Node

func jump(character: CharacterBody3D, jump_velocity: float, gravity: int, delta:float):
	if not character.is_on_floor():
		character.velocity.y -= gravity * delta
	if Input.is_action_just_pressed("jump") and character.is_on_floor():
		character.velocity.y += jump_velocity
