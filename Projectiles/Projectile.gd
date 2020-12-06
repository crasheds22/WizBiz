extends Node2D

export(bool) var PHASING = false;
export(bool) var PIERCING = false;
onready var explosionEffect = preload("res://Effects/ExplosionEffect.tscn");

var velocity = Vector2.ZERO;


func _process(delta):
	position += velocity * delta;


func _on_VisibilityNotifier_viewport_exited(_viewport):
	queue_free();
	return;


func _on_Hitbox_body_entered(_body):
	
	if not PHASING:
		queue_free();
	return;


func _on_Hitbox_area_entered(_area):
	if not PIERCING:
		queue_free();
	return;
	
func _exit_tree():
	Utils.instance_scene_on_main(explosionEffect,position);
	return;

