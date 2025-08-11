class_name Weapons
extends Resource

@export var name: StringName
@export_category("Weapon Orientation")
@export var position: Vector3
@export var rotation: Vector3
@export_category("Visual Settings")
@export var mesh: Mesh
@export var attack_sound: AudioEffect
@export_category("Weapon Stats")
@export var damage: float
@export var range: float
@export var fire_rate: int #hits per second
