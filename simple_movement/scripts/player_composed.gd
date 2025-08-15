extends CharacterBody3D

#Functional parts
@onready var collision_shape_standing = $CollisionShapeStanding
@onready var collision_shape_crouching = $CollisionShapeCrouching
@onready var raycast = $ShapeCast3D
@onready var head = $SpringArm3D
@onready var animations = $Rig/AnimationPlayer
@onready var visuals = $Rig

#Components
@onready var movement := $Components/Movement
@onready var crouch := $Components/Crouch
@onready var look_around := $Components/MouseView
@onready var attack := $Components/Attack
@onready var animation_manager := $Components/AnimationManager
@onready var sound_player := $SoundSource
#Speed vars
var speed_walking: float = 10.0
var speed_current: float
var speed_sprinting: float = 10.0
var speed_crouching: float = 3.8
var speed_lerp: float = 10.0
var jump_velocity: float = 10.0
const gravity: int = 25

#Input vars
var mouse_sens: float = 0.4
var input_dir: Vector2
#Misc
var crouching_depth: float = 0.8
var standing_height: float = 1.6
var is_crouching: bool
var jumps_allowed: int = 2

func _ready() -> void:
	#Locks mouse in window and hides it
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event: InputEvent) -> void:
	#looking around with mouse
	look_around.mouse_look_around(self, event, mouse_sens)


func _physics_process(delta: float) -> void:
	#Moving
	speed_current = speed_walking
	input_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	velocity = movement.get_velocity(self, input_dir, speed_current, delta, speed_lerp)
	#attack
	if Input.is_action_just_pressed("attack"):
		attack.weapon_animation_attack(self)
		sound_player.stream = $WeaponManager.current_weapon.attack_sound
		sound_player.play()
	
	#Jumping
	# should I move jumping to a component? Isn't it too simple for separate func?
	if is_on_floor():
		jumps_allowed = 2
	else: 
		velocity.y -= gravity * delta
	if Input.is_action_just_pressed("jump") and jumps_allowed>0:
		velocity.y += jump_velocity
		jumps_allowed -= 1
	
	#Crouching
	# same 
	if Input.is_action_pressed("crouch"):
		crouch.crouch(self, crouching_depth, delta)
		is_crouching = true
	else:
		crouch.get_node("StandUpCheck").is_stand_up_possible(self, standing_height)
	#Movement itself
	move_and_slide()
	

func _process(delta: float) -> void:
	if velocity:
		visuals.look_at((global_position+Vector3(-velocity.x, 0, -velocity.z)))
	animation_manager.run_animation(self)
