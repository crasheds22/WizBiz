extends Control

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


var mapSheet = load("res://test_map_v1.png");

onready var grid = ResourceLoader.MapData;

var start_x = 4;
var start_y = 4;
var cell_size = 9;
var step_size = 8;
var h_steps = 10;
var v_steps = 8;


func _ready():
	pass;
	
func _draw():
	#Draw Base
	draw_texture_rect_region(mapSheet,Rect2(0,0,96,80),Rect2(0,0,96,80));
	
	#Draw Map
	var i = 0;
	var j = 0;
	
	while i < h_steps:
		while j < v_steps:
			var pos_x = start_x + (i*step_size);
			var pos_y = start_y + (j*step_size);
			
			if grid.get_grid_space(i,j) == 0:
				draw_texture_rect_region(mapSheet,Rect2(pos_x,pos_y,9,9),Rect2(pos_x+96,pos_y,9,9));
			else:
				draw_texture_rect_region(mapSheet,Rect2(pos_x,pos_y,9,9),Rect2(pos_x+96+96,pos_y,9,9));
			j+=1;
		j = 0;
		i+=1;
	return;

