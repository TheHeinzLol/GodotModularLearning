extends CharacterBody3D

#Components
@onready var movement := $Components/Movement
#Speed vars
var speed_walking: float = 5.0
var speed_current: float
var speed_sprinting: float = 10.0
var speed_crouching: float = 3.8
var speed_lerp: float = 10.0
var jump_velocity: float = 10.0
const gravity: int = 25

#Input vars
var mouse_sens: float = 0.4

#Misc
var crouching_depth: float = 0.8

func _physics_process(delta: float) -> void:
	speed_current = speed_walking
	velocity = movement.get_velocity(speed_current, self, delta, speed_lerp)
	print(velocity)
	move_and_slide()
