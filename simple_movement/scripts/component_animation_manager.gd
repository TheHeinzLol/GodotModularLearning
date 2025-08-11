class_name AnimationManagerComponent
extends Node

func run_animation(character: CharacterBody3D) -> void:
	if character.velocity:
		if character.is_crouching:
			if character.animations.current_animation != "Crouch_Fwd":
				character.animations.play("Crouch_Fwd")
		else:
			if character.animations.current_animation != "Sprint":
				character.animations.play("Sprint")
	else:
		if character.is_crouching:
			if character.animations.current_animation != "Crouch_Idle":
				character.animations.play("Crouch_Idle")
		else:
			if character.animations.current_animation != "Pistol_Idle":
				character.animations.play("Pistol_Idle")
	if !character.is_on_floor():
		if character.animations.current_animation != "Jump":
				character.animations.play("Jump")
