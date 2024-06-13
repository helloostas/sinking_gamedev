extends CharacterBody3D

# Player nodes

@onready var head = $head
@onready var standing_collision_shape = $standing_collision_shape
@onready var crouching_collision_shape = $crouching_collision_shape
@onready var ray_cast_3d = $RayCast3D

# Abilities
var global_abilities = ["double_jump", "dash", "sink", "lunge"]
var on_hand_abilities = ["double_jump", "sink"]

# Speed varibles
var current_speed = 5.0

const walking_speed = 7.0
const sprinting_speed = 9.0
const crounching_speed = 3.0

# States
var walking = false
var sprinting = false
var crouching = false

# Movement variables
const jump_velocity = 6
const double_jump_velocity = 10
const sink_velocity = 20
var crouch_depth = -0.5
var lerp_speed = 10.0

# Dash Variables
const dash_velocity = 80
var dash_timer = 0.0
const dash_duration = 0.2
var dash_direction
var is_dashing = false

# Input variables

const mouse_sens = 0.4
var direction = Vector3.ZERO

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

# Mouse movement

func _input(event):
	if event is InputEventMouseMotion:
		rotate_y(deg_to_rad(-event.relative.x * mouse_sens))
		head.rotate_x(deg_to_rad(-event.relative.y * mouse_sens))
		head.rotation.x = clamp(head.rotation.x, deg_to_rad(-89), deg_to_rad(89))

func _physics_process(delta):
	
	# Handling movement states
	
	# Crouching
	
	if Input.is_action_pressed("crounch"):
		
		current_speed = crounching_speed
		head.position.y = lerp(head.position.y, 1.8 + crouch_depth, delta * lerp_speed)
		
		standing_collision_shape.disabled = true
		crouching_collision_shape.disabled = false
		
		if not is_on_floor():
			current_speed = walking_speed
		
		walking = false
		sprinting = false
		crouching = true
		
	elif !ray_cast_3d.is_colliding():
		
		# Standing
		standing_collision_shape.disabled = false
		crouching_collision_shape.disabled = true
		head.position.y = lerp(head.position.y, 1.8, delta * lerp_speed)
		
		if Input.is_action_pressed("sprint"):
			
			# Sprinting
			current_speed = sprinting_speed
			
			walking = false
			sprinting = true
			crouching = false
		else:
			
			# Walking
			
			current_speed = walking_speed
			walking = true
			sprinting = false
			crouching = false

	if not is_on_floor():
	# Add the gravity.
		velocity.y -= gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = jump_velocity

	# Get the input direction and handle the movement/deceleration.
	var input_dir = Input.get_vector("left", "right", "forward", "backward")
	
	#lerp speed - will decellerate from whatever speed player is moving at
	direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if direction:
		velocity.x = direction.x * current_speed
		velocity.z = direction.z * current_speed
	else:
		velocity.x = move_toward(velocity.x, 0, current_speed)
		velocity.z = move_toward(velocity.z, 0, current_speed)
	
	if is_dashing:
			velocity += dash_direction * -dash_velocity
			velocity.y = 0  # Keep the dash horizontal
	
	move_and_slide()

# Abilities
	if Input.is_action_just_pressed("ability"):
		print(on_hand_abilities)
		
		if len(on_hand_abilities) > 0:
			if on_hand_abilities[0] == "double_jump":
				velocity.y = double_jump_velocity
				print(on_hand_abilities[0])
				on_hand_abilities.remove_at(0)
				print(on_hand_abilities)
				
			elif on_hand_abilities[0] == "dash":
				is_dashing = true
				$dash_timer.start(dash_duration)
				dash_direction = transform.basis.z
				print(on_hand_abilities[0]) 
				#on_hand_abilities.remove_at(0)
				print(on_hand_abilities)
				
			elif on_hand_abilities[0] == "sink":
				# add sink code here
				velocity.y = -sink_velocity
				print(on_hand_abilities[0])
				on_hand_abilities.remove_at(0)
				print(on_hand_abilities)
				
			elif on_hand_abilities[0] == "lunge":
				# add lunge code here
				print(on_hand_abilities[0])
				on_hand_abilities.remove_at(0)
				print(on_hand_abilities)
				
			else:
				pass
	
	# Switching Between Abilities
	if Input.is_action_just_pressed("switch"):
		on_hand_abilities.reverse()
		print(on_hand_abilities)


func _dash_end():
	is_dashing = false
