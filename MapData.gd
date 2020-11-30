extends Resource
class_name MapData

var map_width = 10;
var map_height = 8;
var map_grid = [];

func get_map():
	return map_grid;

func get_grid_space(x,y):
	return map_grid[x][y];
	
func set_grid_space(x,y,val):
	map_grid[x][y] = val;

func _init():
	var i = 0;
	var j = 0;
	
	while i < map_width:
		map_grid.append([]);
		while j < map_height:
			map_grid[i].append(randi()%2);
			j+= 1;
		j = 0;
		i+= 1;

