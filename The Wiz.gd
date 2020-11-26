extends KinematicBody2D

const ACCELERATION = 512
const MAX_SPEED = 64
const FRICTION = 0.25
const AIR_RESISTANCE = 0.02
const GRAVITY = 200
const JUMP_FORCE = 128

var motion = Vector2.ZERO
var doubleJumped = false

onready var sprite = $Sprite
onready var animationPlayer = $AnimationPlayer

func anim_control(delta):
	var x_input = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	
	if is_on_floor():
		if x_input != 0:
			animationPlayer.play("Walk")
		else:
			animationPlayer.play("Idle")
	else:
		if motion.y > 0:
			animationPlayer.play("Falling")
		else:
			if doubleJumped:
				animationPlayer.play("Double jump")
			else:
				animationPlayer.play("Jump")
	

func _process(delta):
	anim_control(delta)

func _physics_process(delta):
	var x_input = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	
	if x_input != 0:
		motion.x += x_input * ACCELERATION * delta
		motion.x = clamp(motion.x, -MAX_SPEED, MAX_SPEED)
		sprite.flip_h = x_input < 0
	
	motion.y += GRAVITY * delta
	
	if is_on_floor():
		doubleJumped = false
		
		if x_input == 0:
			motion.x = lerp(motion.x, 0, FRICTION)
		
		if Input.is_action_just_pressed("jump"):
			motion.y = -JUMP_FORCE
	else:
		if Input.is_action_just_pressed("jump") and !doubleJumped:
			motion.y = -JUMP_FORCE
			doubleJumped = true
		
		if Input.is_action_just_released("jump") and motion.y < -JUMP_FORCE / 2:
			motion.y = -JUMP_FORCE / 2
		
		if x_input == 0:
			motion.x = lerp(motion.x, 0, AIR_RESISTANCE)
	
	motion = move_and_slide(motion, Vector2.UP)
