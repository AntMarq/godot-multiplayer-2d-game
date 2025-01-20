extends Control
class_name LobbyMenu

#Variables
@export var hostButton : Button
@export var joinButton : Button
@export var addressEntry : LineEdit

const SERVER_PORT = 9999
const SERVER_IP = "localhost"

var enet_peer = ENetMultiplayerPeer.new()

func _create_server() -> void:
	print("host")
	enet_peer.create_server(SERVER_PORT)
	multiplayer.multiplayer_peer = enet_peer
	GlobalVariables.server_is_loaded = true
	get_tree().change_scene_to_file("res://scenes/levels/world.tscn")

func _join_server() -> void:
	enet_peer.create_client("localhost", SERVER_PORT)
	print(enet_peer)
	multiplayer.multiplayer_peer = enet_peer
	get_tree().change_scene_to_file("res://scenes/levels/world.tscn")

#func _start_game() -> void:
	#if(multiplayer.multiplayer_peer != null):
		#get_tree().change_scene_to_file("res://scenes/levels/world.tscn")
