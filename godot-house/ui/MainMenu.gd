# ui/MainMenu.gd
extends Control

const PORT = 7000

@onready var name_input = %NameInput
@onready var ip_input = %IPInput

	
func _ready():
	%MapFileSelectDialog.file_selected.connect(func(path):
		on_file_selected(path);
	)

func _on_host_pressed():
	%MapFileSelectDialog.visible = true;
	
func on_file_selected(path: String):
	Global.set_player_name(name_input.text)
	Global.is_host = true
	Global.set_apartment_path(path);
	var peer = ENetMultiplayerPeer.new()
	var result = peer.create_server(PORT, 8)
	if result != OK:
		push_error("Impossible de créer le serveur")
		return
	get_tree().multiplayer.multiplayer_peer = peer
	get_tree().change_scene_to_file("res://main/Main.tscn")

func _on_join_pressed():
	Global.set_player_name(name_input.text)
	Global.is_host = false
	var peer = ENetMultiplayerPeer.new()
	var result = peer.create_client(ip_input.text, PORT)
	if result != OK:
		push_error("Impossible de se connecter au serveur")
		return
	get_tree().multiplayer.multiplayer_peer = peer
	get_tree().change_scene_to_file("res://main/Main.tscn")


func _on_join_button_pressed() -> void:
	pass # Replace with function body.
