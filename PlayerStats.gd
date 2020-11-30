extends Resource
class_name PlayerStats

var max_health = 4;
var max_orbs = 10;
var health = max_health setget set_health;

signal player_died;
signal health_changed;
signal max_health_increased;

func set_health(value):
	var new_health = clamp(value,0,max_health);
	if new_health != health:
		health = new_health;
		emit_signal("health_changed");
	if health == 0:
		emit_signal('player_died');
	return health;

func set_max_health(value):
	max_health = clamp(value,1,max_orbs);
	health = max_health;
	emit_signal("max_health_increased");
	return;

func get_max_health():
	return max_health;
	
func get_health():
	return health;
