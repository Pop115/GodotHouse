# network/MultiplayerManager.gd
extends Node

const PLAYER_SCENE = preload("res://player/Player.tscn")

func _ready():
	# Connecter signaux réseau
	get_tree().multiplayer.peer_connected.connect(_on_peer_connected)
	get_tree().multiplayer.peer_disconnected.connect(_on_peer_disconnected)

	if Global.is_host:
		_spawn_player(get_tree().get_multiplayer().get_unique_id(), Global.player_name)

func _on_peer_connected(id: int):
	print("Nouveau joueur connecté :", id)
	if Global.is_host:
		rpc_id(id, "spawn_player_remote", Global.player_name)

func _on_peer_disconnected(id: int):
	var player = get_node_or_null("Players/%s" % id)
	if player:
		player.queue_free()

@rpc("any_peer")
func spawn_player_remote(name: String):
	_spawn_player(get_tree().get_multiplayer().get_remote_sender_id(), name)

func _spawn_player(id: int, name: String):
	var player = PLAYER_SCENE.instantiate()
	player.name = str(id)
	player.set_multiplayer_authority(id)
	player.global_position = Vector3(randf() * 3, 1, randf() * 3)
	player.set_pseudo(name)
	if not has_node("Players"):
		var players_root = Node3D.new()
		players_root.name = "Players"
		add_child(players_root)
	get_node("Players").add_child(player)
