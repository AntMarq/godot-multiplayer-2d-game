extends Node

var enet_peer = ENetMultiplayerPeer.new()

var _players_spawn_node


func _unhandled_input(event):
	if Input.is_action_just_pressed("quit"):
		var peer_id = multiplayer.get_unique_id()
		remove_player(peer_id)
		multiplayer.multiplayer_peer.close()
		multiplayer.multiplayer_peer = null
		get_tree().change_scene_to_file("res://LobbyMenu_old.tscn")
		
func _ready() -> void:
	load_server_for_host()
	
#func random_start_position():
	#spawn_location.position.y = spawn_location.position.y + 30
	#spawn_location.position.x = spawn_location.position.x +  randf_range(0,10)

		
func load_server_for_host():
	if GlobalVariables.server_is_loaded:
		multiplayer.peer_connected.connect(add_player)
		multiplayer.peer_disconnected.connect(remove_player)
		_players_spawn_node = get_tree().get_current_scene().get_node("Players")
		add_player(multiplayer.get_unique_id())
		GlobalVariables.server_is_loaded = false

func add_player(peer_id):
	print("add_player", peer_id)
	var player_scene = preload("res://objects/actors/rogue-player/rogue-player.tscn")
	var player = player_scene.instantiate()
	player.name = str(peer_id)
	_players_spawn_node.add_child(player, true)

func remove_player(peer_id):
	print("Player %s left the game!" % peer_id)
	if not _players_spawn_node.has_node(str(peer_id)):
		return
	_players_spawn_node.get_node(str(peer_id)).queue_free()

func _exit_tree():
	if not multiplayer.is_server():
		return
	multiplayer.peer_connected.disconnect(add_player)
	multiplayer.peer_disconnected.disconnect(remove_player)
