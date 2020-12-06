extends Resource
class_name PlayerStats

var max_health = 4;
var max_orbs = 10;
var health = max_health setget set_health;
var unlocks = [true,false,false,false];
var selected_power = 0 setget set_power;

signal player_died;
signal health_changed;
signal max_health_increased;
signal power_swapped(index);
signal power_unlocked(index);

func set_power(value):
	value = clamp(value,0,3);
	if unlocks[value] == true:
		selected_power = value;
		emit_signal("power_swapped",value);
	else:
		if value + 1 < 4:
			set_power(value+1);
	return;
	
func power_unlocked(power_index):
	if(unlocks[power_index == false]):
		unlocks[power_index] = true;
		emit_signal('power_unlocked',power_index);
	return;

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
