extends Node

var enet_peer = ENetMultiplayerPeer.new()

func _unhandled_input(event):
	pass
	
	#if Input.is_action_just_pressed("quit"):
		#var peer_id = multiplayer.get_unique_id()
		#remove_player(peer_id)
		#multiplayer.multiplayer_peer.close()
		#multiplayer.multiplayer_peer = null
		#get_tree().change_scene_to_file("res://LobbyUI.tscn")
		#get_tree().quit()
		
func _ready() -> void:
	load_server_for_host()
	random_start_position()
	
func random_start_position():
	self.position.y = self.position.y + 30
	self.position.x = self.position.x +  randf_range(0,10)

		
func load_server_for_host():
	if GlobalVariables.server_is_loaded:
		print("load_server_for_host")
		multiplayer.peer_connected.connect(add_player)
		multiplayer.peer_disconnected.connect(remove_player)
		add_player(multiplayer.get_unique_id())
		GlobalVariables.server_is_loaded = false

func add_player(peer_id):
	prints("add_player", peer_id)

	var player_scene = preload("res://objects/actors/rogue-player/rogue-player.tscn")
	var player = player_scene.instantiate()
	player.name = str(peer_id)
	add_child(player)

func remove_player(peer_id):
	prints("Remove player", peer_id)
	var player = get_node_or_null(str(peer_id))
	if player:
		prints("Player queue free", peer_id)
		player.queue_free()

func _on_multiplayer_spawner_spawned(node):
	if node.is_multiplayer_authority():
		print("player spawned : ", node)

func _exit_tree():
	if not multiplayer.is_server():
		return
	multiplayer.peer_connected.disconnect(add_player)
	multiplayer.peer_disconnected.disconnect(remove_player)
