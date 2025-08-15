class_name WeaponManager
extends Node3D

@export var current_weapon: WeaponResource
@export var character: CharacterBody3D
@export var bullet_raycast: RayCast3D
@export var view_model_container: Node3D
var current_weapon_view_model: Node3D

func update_weapon_model() -> void:
	if current_weapon != null:
		if current_weapon.mesh:
			current_weapon_view_model = current_weapon.mesh.instantiate()
			view_model_container.add_child(current_weapon_view_model)
			var weapon_node = view_model_container.get_child(0)
			weapon_node.position = current_weapon.position
			weapon_node.rotation.x = deg_to_rad(current_weapon.rotation.x)
			weapon_node.rotation.y = deg_to_rad(current_weapon.rotation.y)
			weapon_node.rotation.z = deg_to_rad(current_weapon.rotation.z)
			print(weapon_node.name, weapon_node.rotation)
func _ready() -> void:
	update_weapon_model()

func _process(delta: float) -> void:
	pass
