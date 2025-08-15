class_name MouseViewComponent
extends Node

func mouse_look_around(character: CharacterBody3D, event: InputEvent, mouse_sense: float):
	if event is InputEventMouseMotion:
		character.rotate_y(-deg_to_rad(event.relative.x * mouse_sense))
		character.head.rotate_x(-deg_to_rad(event.relative.y * mouse_sense))
		character.head.rotation.x = clampf(character.head.rotation.x, deg_to_rad(-50), deg_to_rad(90))
