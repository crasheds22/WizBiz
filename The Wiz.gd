extends KinematicBody2D

const ACCELERATION = 512
const MAX_SPEED = 64
const FRICTION = 0.25
const AIR_RESISTANCE = 0.02
const GRAVITY = 200
const JUMP_FORCE = 128

const POST_CAST_WAIT = 0.5

var motion = Vector2.ZERO
var doubleJumped = false
var x_input = 0
var postCastTimer = 0

onready var sprite 			= $Sprite
onready var animationPlayer = $AnimationPlayer

func anim_control(delta):
	if Input.is_action_pressed("fire"):
		postCastTimer = 0
		if is_on_floor():
			animationPlayer.play("Pre cast spell")
		else:
			if motion.y > 0:
				animationPlayer.play("Falling pre cast")
			else:
				if doubleJumped:
					animationPlayer.play("Double jump pre cast")
				else:
					animationPlayer.play("Jump pre cast")
	else: 	
		if Input.is_action_just_released("fire"):
			if is_on_floor():
					animationPlayer.play("Cast spell")
			else:
				if motion.y > 0:
					animationPlayer.play("Falling cast")
				else:
					if doubleJumped:
						animationPlayer.play("Double jump cast")
					else:
						animationPlayer.play("Jump cast")
		else:
			if postCastTimer >= POST_CAST_WAIT:
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
	
	postCastTimer += delta

func _process(delta):
	x_input = Input.get_action_strength("right") - Input.get_action_strength("left")
	
	anim_control(delta)

func _physics_process(delta):
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
		
		if Input.is_action_just_released("jump") and motion.y < -JUMP_FORCE / 2.0:
			motion.y = -JUMP_FORCE / 2.0
		
		if x_input == 0:
			motion.x = lerp(motion.x, 0, AIR_RESISTANCE)
	
	motion = move_and_slide(motion, Vector2.UP)
