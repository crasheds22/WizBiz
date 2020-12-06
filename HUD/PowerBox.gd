extends Control

onready var boxes = [$Sprite,$Sprite2,$Sprite3,$Sprite4];
onready var start_frames = [0,3,6,9];
onready var end_frames = [2,5,8,11];
onready var playerStats = ResourceLoader.PlayerStats;
onready var selected = 0;

func _ready():
	playerStats.connect("power_unlocked",self,"unlock_power")
	playerStats.connect("power_swapped",self,"swap_power");
	
	boxes[0].frame = 2;
	boxes[1].frame = 3;
	boxes[2].frame = 6;
	boxes[3].frame = 9;
	return;

func _process(delta):
	#TODO: CLean this input up
	#TODO: Fix not bieng able to recursively select left
	if Input.is_action_just_pressed("left"):
		playerStats.set_power(selected-1);
	
	if Input.is_action_just_pressed("right"):
		playerStats.set_power(selected+1);
	
	if Input.is_action_just_pressed("ui_down"):
		playerStats.power_unlocked(3);
	return;
	
	
func swap_power(index):
	boxes[selected].frame -= 1;
	boxes[index].frame += 1;
	selected = index;
	return;
	
func unlock_power(index):
	boxes[index].frame = end_frames[index] - 1;	
	return;
	
		
