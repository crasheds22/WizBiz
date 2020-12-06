extends Control


onready var health_sprite = $OrbContainer/Sprite;

func set_index(index):
	health_sprite.frame = index;
	return;

