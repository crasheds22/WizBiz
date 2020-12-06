extends "res://Projectiles/Projectile.gd"


func _ready():
	set_process(false);
	return;

func _exit_tree():
	Utils.instance_scene_on_main(explosionEffect,position);
	return;
