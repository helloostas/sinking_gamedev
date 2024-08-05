extends CharacterBody3D

# Player nodes

@onready var head = $head
@onready var standing_collision_shape = $standing_collision_shape
@onready var crouching_collision_shape = $crouching_collision_shape
@onready var ray_cast_3d = $RayCast3D

# Abilities
var global_abilities = ["double_jump", "dash", "sink", "lunge"]
var on_hand_abilities = []

# Speed varibles
var current_speed = 5.0

const walking_speed = 9.0
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
var has_dashed = false

var time = 0

# Dash Variables
const dash_velocity = 10
var dash_timer = 0.0
const dash_duration = 0.1
var dash_direction
var is_dashing = false

# Lunge Variables
var lunge_dir = Vector3()
var is_lunging = false
var lunge_velocity = 10
var lunge_duration = 0.2

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
	if is_on_floor() and has_dashed:
		has_dashed = false
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

	if not is_on_floor() and not is_dashing: #and not is_lunging:
	# Add the gravity.
		if not has_dashed:
			velocity.y -= gravity * delta
		else:
			velocity.y -= gravity * delta / 2

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = jump_velocity

	# Get the input direction and handle the movement/deceleration.
	var input_dir = Input.get_vector("left", "right", "forward", "backward")
	
	#lerp speed - will decellerate from whatever speed player is moving at
	direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	# Tweaking the gravity to maintain horizontal momentum while using "dash"
	if direction and not is_dashing:
		if is_on_floor():
			velocity.x = lerp(velocity.x, direction.x * current_speed, 0.2)
			velocity.z = lerp(velocity.z, direction.z * current_speed, 0.2)
		else:
			velocity.x = lerp(velocity.x, direction.x * current_speed, 0.05)
			velocity.z = lerp(velocity.z, direction.z * current_speed, 0.05)
	else:
		if is_on_floor():
			velocity.x = lerp(velocity.x, 0.0, 0.1)
			velocity.z = lerp(velocity.z, 0.0, 0.1)
		else:
			velocity.x = lerp(velocity.x, 0.0, 0.1)
			velocity.z = lerp(velocity.z, 0.0, 0.1)
	
	if is_dashing:
		time += delta
		velocity += dash_direction * -dash_velocity
		velocity.y = 0  # Keep the dash horizontal
		
		
	if is_lunging:
		time += delta
		velocity += lunge_dir * -lunge_velocity
		velocity.y = (lunge_dir * dash_velocity).z * 2
		print(velocity.y)
	
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
				has_dashed = true
				print(on_hand_abilities[0]) 
				on_hand_abilities.remove_at(0)
				print(on_hand_abilities)
				
			elif on_hand_abilities[0] == "sink":
				# add sink code here
				velocity.y = -sink_velocity
				print(on_hand_abilities[0])
				on_hand_abilities.remove_at(0)
				print(on_hand_abilities)

			elif on_hand_abilities[0] == "lunge":
				is_lunging = true
				$lunge_timer.start(lunge_duration)
				lunge_dir = $head.transform.basis.z
				lunge_dir = transform.basis.z
				print(on_hand_abilities[0])
				on_hand_abilities.remove_at(0)
				print(on_hand_abilities)
				
			else:
				pass
	
	# Switching Between Abilities
	if Input.is_action_just_pressed("switch"):
		on_hand_abilities.reverse()
		print(on_hand_abilities)

# On dash and lunge end funcitons: (Makes each ability stop on timer end)

func _dash_end():
	is_dashing = false
	velocity.y = 0

func _on_lunge_timer_timeout():
	is_lunging = false
