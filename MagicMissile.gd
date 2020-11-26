extends KinematicBody2D

var speed = 150
var velocity = Vector2()

onready var animationPlayer = $AnimationPlayer

func start(pos, dir):
	position = pos
	rotation_degrees  = dir;
	velocity = Vector2(speed, 0).rotated(rotation)

func _process(delta):
	rotate(deg2rad(10))

func _physics_process(delta):
	animationPlayer.play("Flying")
	
	var collision = move_and_collide(velocity * delta)
	if collision:
		if collision.collider.has_method("getHurt"):
			collision.collider.getHurt()
		queue_free()
