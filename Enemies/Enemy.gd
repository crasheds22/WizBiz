extends KinematicBody2D

export (int) var MAX_SPEED = 15;
export (int) var MAX_SLOPE_ANGLE = 46;
var motion = Vector2.ZERO;

onready var stats = $EnemyStats;
onready var deathEffect = preload("res://Effects/EnemyDeathEffect.tscn");

func _on_Hurtbox_hit(damage, _hitbox):
	stats.health -= damage;
	return;
	


func _on_EnemyStats_enemy_died():
	var _dEffect = Utils.instance_scene_on_main(deathEffect,global_position);
	queue_free();
	return;
