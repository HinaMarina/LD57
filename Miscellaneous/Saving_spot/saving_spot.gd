extends Area2D
@export var scene_path:String
@export var anim:AnimatedSprite2D

var can_save := true

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		if body._Machine.is_holding_girl == false:
			return
	if can_save:
		PlayerDeathManager.save_position(self.global_position,scene_path)
		anim.play("Saved")
		can_save = false
