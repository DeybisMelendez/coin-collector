extends Control

func _ready():
	$VBoxContainer/Play.connect("button_up", self, "play")

func play():
	get_tree().change_scene("res://scenes/levels/1.tscn")