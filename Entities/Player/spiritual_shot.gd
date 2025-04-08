extends CharacterBody2D
@export var anim_sprite:AnimatedSprite2D
@export var soundFX:AudioStreamPlayer2D

func _physics_process(delta: float) -> void:
	move_and_slide()

	

func shoot(direction:Vector2):
	self.velocity = direction*200
	await get_tree().create_timer(0.3).timeout
	if anim_sprite.animation == "explosion":
		return
	queue_free()


func _on_spritual_shot_body_entered(body: Node2D) -> void:
	if body.has_method("get_damage"):
		self.velocity = Vector2.ZERO
		anim_sprite.play("explosion")
		if body.get_parent() is nightmare:
			self.global_position = body.global_position + Vector2(0,-10)
			soundFX.play()
			body.get_damage()
			await anim_sprite.animation_finished
		else:
			body.get_damage()
			
		anim_sprite.visible=false
		await soundFX.finished
		queue_free()
