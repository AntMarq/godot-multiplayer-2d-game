extends PathFollow2D

var direction = 1
	
func _physics_process(delta: float) -> void:
	print("direction:", direction)
	print("progress:", progress)

	progress += direction
	if progress_ratio >= 1 or progress_ratio <= 0:
		direction = -direction

	#_move_right()
	#if animation_player_optional:
		#multiplayer.peer_connected.connect(_on_player_connected)
		
#POC des TWEEN pour animer les plateformes. Bcp plus efficaces que les animation player
#func _move_right():
	#var tween = create_tween()
	#tween.tween_property(self, "position", position + Vector2(distance, 0), distance/100)
	#tween.tween_callback(_move_left)
#
#func _move_left():
	#var tween = create_tween()
	#tween.tween_property(self, "position", position + Vector2(-distance, 0), distance/100)
	#tween.tween_callback(_move_right)
	
#func _on_player_connected(id):
	#if not multiplayer.is_server():
		#animation_player_optional.stop()
		#animation_player_optional.set_active(false)
