# network/MultiplayerManager.gd
extends Node


var IP_ADDRESS: String = "localhost"
const PORT: int = 42069

var peer : ENetMultiplayerPeer;

const PLAYER_SCENE = preload("res://player/Player.tscn")

func start_server() -> void:
	peer = ENetMultiplayerPeer.new()
	peer.create_server(PORT)
	multiplayer.multiplayer_peer = peer;
	
func start_client() -> void:
	peer = ENetMultiplayerPeer.new()
	peer.create_client(IP_ADDRESS, PORT)
	multiplayer.multiplayer_peer = peer;
