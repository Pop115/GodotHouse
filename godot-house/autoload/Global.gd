# autoload/Global.gd
extends Node

var player_name: String = "Anonyme"
var apartment_path : String;
var is_host: bool = false

func set_player_name(name: String):
	player_name = name.strip_edges()

func set_apartment_path(path: String):
	apartment_path = path;
