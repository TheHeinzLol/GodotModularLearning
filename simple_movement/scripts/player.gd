extends CharacterBody3D
#Player nodes
@onready var animations = $AnimationPlayer
@onready var head = $SpringArm3D
@onready var collision_shape_standing = $CollisionShapeStanding
@onready var collision_shape_crouching = $CollisionShapeCrouching
@onready var raycast = $RayCast3D

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
var direction: Vector3 = Vector3.ZERO

#Misc
var crouching_depth: float = 0.8



func _ready() -> void:
	#Locks mouse in window and hides it
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
	if event is InputEventMouseMotion:
		#godot uses radians, but we'd rather use degrees
		#otherwise rotation would be insane
		rotate_y(-deg_to_rad(event.relative.x * mouse_sens))
		head.rotate_x(-deg_to_rad(event.relative.y * mouse_sens))
		#limit vertical rotation
		head.rotation.x = clampf(head.rotation.x, deg_to_rad(-75), deg_to_rad(90))

func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	# Add gravity
	if not is_on_floor():
		velocity.y -= gravity * delta
	#Crouch check. Changing mesh and collision shapes for croucing.
	# Note: if you crouch - no sprint
	# Also since there is no check for is_on_floor, you can sprint mid air.
	# I left it like this until I fix that you can'tjump while sprinting
	if Input.is_action_pressed("crouch"):
		speed_current = speed_crouching
		head.position.y = lerp(head.position.y, crouching_depth, delta * speed_lerp)
		
	# Checking for ability to stand up, sprint check and speeding up
	elif !raycast.is_colliding():
		collision_shape_standing.disabled = false
		collision_shape_crouching.disabled = true
		head.position.y = 1.6
		if Input.is_action_pressed("sprint"):
			speed_current = speed_sprinting
		else:
			speed_current = speed_walking
	
	# Handle jump
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y += jump_velocity
	
	# Movement
	#Get directions
	# input_dir is 2d vector since we only need two for determening movement on a plane.
	var input_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	# It has x and y attributes, but we will transfer them into 3d vector `direction`
	# which has x, y, and z attributes. X and Z do span horizontal plane so
	# there is input_dir.y insead of input_dir.z.
	# We also normalize direction so player doesn't move faster diagonally
	# lerp gives smooth start
	direction = lerp(direction,
			transform.basis * Vector3(input_dir.x, 0, input_dir.y).normalized(),
	 		delta * speed_lerp)
	# if pressing movement keys
	if direction:
		velocity.x = direction.x * speed_current
		velocity.z = direction.z * speed_current
	# if not, stop immediately. Use move_towards for inertia
	else:
		animations.play("Idle")
		#move_toward decreases speed, but larger vector slows longer,
		#so there is a drift toward axis with greater velocity
		#velocity.x = move_toward(velocity.x, 0, speed_current * delta * 7) 
		#velocity.z = move_toward(velocity.z, 0, speed_current * delta * 7) 
		#immediate stop
		velocity.z = 0
		velocity.x = 0
	#print("x:%s "  %velocity.x, "z:%s " %velocity.z) # to see velocity
	print(velocity)
	move_and_slide()
