extends Control

onready var playerStats = ResourceLoader.PlayerStats;
onready var hOrb = preload("res://HealthOrb.tscn");
var hOrbList = [];

func _ready():
	playerStats.connect("health_changed",self,"update_health");
	playerStats.connect("max_health_increased",self,"set_orbs");
	set_orbs();

func update_health():
	var new_health = playerStats.get_health();
	print_debug("Health: " + str(new_health));
	print_debug("Orb List: " + str(hOrbList.size()));
	for i in range(hOrbList.size()):
		
		if(i < new_health):
			hOrbList[i].set_index(0);
		else:
			hOrbList[i].set_index(2);

func _process(delta):
	#health_bar_debug();
	pass;
	
func set_orbs():
	for i in hOrbList:
		remove_child(i);
		i.queue_free();
	
	var nOrbs = playerStats.get_max_health();
	hOrbList = [];
	for i in range(nOrbs):
		var newOrb = hOrb.instance();
		add_child(newOrb);
		newOrb.set_index(0);
		newOrb.set_position(Vector2(i*12,0));
		hOrbList.append(newOrb);
	
func health_bar_debug():
	if(Input.is_action_just_pressed("ui_down")):
		playerStats.set_max_health(playerStats.get_max_health()+1);	
	if(Input.is_action_just_pressed("ui_left")):
		playerStats.set_health(playerStats.get_health()-1);
	if(Input.is_action_just_pressed("ui_right")):
		playerStats.set_health(playerStats.get_health()+1);	
	
	
	
