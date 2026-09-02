extends CharacterBody2D

@onready var sprite = $AnimatedSprite2D

const SPEED = 150.0
const ACCELERATION = 800.0
const FRICTION = 900.0
const COYOTE_TIME = 0.06
const JUMP_BUFFER_TIME = 0.1

# Jump settings
const INITIAL_JUMP_VELOCITY = -230.0
const JUMP_HOLD_FORCE = -620.0
const MAX_JUMP_HOLD_TIME = 0.3

var coyote_timer = 0.0
var jump_hold_timer = 0.0
var is_jumping = false
var jump_buffer_time = 0.0


func _physics_process(delta: float) -> void:

	# Coyote time
	if is_on_floor():
		coyote_timer = COYOTE_TIME
	else:
		coyote_timer -= delta

	# Gravity
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Jump buffer
	if Input.is_action_just_pressed("jump"):
		jump_buffer_time = JUMP_BUFFER_TIME
	else:
		jump_buffer_time -= delta

	# Start jump
	if jump_buffer_time > 0 and coyote_timer > 0:
		velocity.y = INITIAL_JUMP_VELOCITY
		jump_hold_timer = 0.0
		is_jumping = true
		coyote_timer = 0.0
		jump_buffer_time = 0.0

	# Extra jump force while holding
	if is_jumping and Input.is_action_pressed("jump"):
		if jump_hold_timer < MAX_JUMP_HOLD_TIME:
			velocity.y += JUMP_HOLD_FORCE * delta
			jump_hold_timer += delta
		else:
			is_jumping = false

	# Stop extra force when released
	if Input.is_action_just_released("jump"):
		is_jumping = false

	# Horizontal movement
	var direction := Input.get_axis("move_left", "move_right")

	if is_on_floor():
		if direction == 0:
			sprite.play("idle")
		else:
			sprite.play("run")
	else:
		sprite.play("jump")

	if direction:
		velocity.x = move_toward(
			velocity.x,
			direction * SPEED,
			ACCELERATION * delta
			)
			
		if direction < 0:
			sprite.flip_h = true
		elif direction > 0:
			sprite.flip_h = false
	else:
		velocity.x = move_toward(
			velocity.x, 
			0,
			FRICTION * delta
		)
		
	move_and_slide()
