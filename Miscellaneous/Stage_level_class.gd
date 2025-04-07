class_name stage_level  extends Node2D

@export var player_initial_spot:Vector2
@export var player_final_spot:Vector2
@export var camera_limit_diagonal_right:Node2D
@export var camera_limit_diagonal_left:Node2D

func _on_this_door_body_entered(body: Node2D) -> void:
	var cave_path = "res://Scenes/Cave/Cave.tscn"
	var position_target = Vector2(176,-48)
	var player_:player_node
	if body is Player:
		player_ = body.get_parent()
	PlayerDeathManager.change_scene(position_target,cave_path,player_)
