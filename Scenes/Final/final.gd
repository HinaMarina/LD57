extends stage_level

@export var areatel:Area2D
@export var animatorfinal:AnimationPlayer
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		if body._Machine.is_holding_girl:
			body.velocity = Vector2.ZERO
			body.global_position = areatel.global_position
			body.visible = false
			animatorfinal.play("fade_in")
			await animatorfinal.animation_finished
			var scene = load(next_scene)
			get_tree().call_deferred("change_scene_to_packed", scene)
