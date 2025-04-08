extends stage_level


func _ready() -> void:
	player.Camera.limit_bottom = camera_limit_diagonal_left.global_position.y
	player.Camera.limit_left = camera_limit_diagonal_left.global_position.x
	player.Camera.limit_right = camera_limit_diagonal_right.global_position.x
	player.Camera.limit_top = camera_limit_diagonal_right.global_position.y


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		var scene = load(next_scene)
		get_tree().call_deferred("change_scene_to_packed", scene)
