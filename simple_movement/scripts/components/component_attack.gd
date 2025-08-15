extends Node
var animation_length: float = 2.0
var tween: Tween

func reset_tween() -> void:
	if tween:
		tween.kill()
	tween= create_tween()
	

func weapon_animation_attack(character: CharacterBody3D) -> void:
	reset_tween()
	tween.set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_BACK)
	tween.tween_property(%ViewContainer, "position", Vector3(0,0,-0.5), 0.15)
	tween.parallel().tween_property(%ViewContainer, "rotation", Vector3(deg_to_rad(-70),0,0), 0.15)
	tween.set_trans(Tween.TRANS_LINEAR)
	tween.tween_property(%ViewContainer, "position", Vector3(0,0,0), 0.05)
	tween.parallel().tween_property(%ViewContainer, "rotation", Vector3(deg_to_rad(0),0,0), 0.05)
