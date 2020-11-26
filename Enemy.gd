extends KinematicBody2D

const GRAVITY = 200

signal enemy_collision

var motion = Vector2.ZERO

func _ready():
	#You do nothing
	#You die
	pass

func _process(delta):
	motion.y += GRAVITY * delta
	motion.x = 0
	

func getHurt():
	emit_signal("enemy_collision")
