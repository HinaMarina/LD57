extends Area2D

#func _physics_process(delta: float) -> void:
	#var tween = create_tween()
	#tween.tween_property(self,'global_position',global_position+50*Vector2.RIGHT,1.2)
	#await tween.finished
	#queue_free()
	
func _on_body_entered(body: Node2D) -> void:
	if body.has_method("get_damage"):
		body.get_damage()
		queue_free()

func shoot(direction:Vector2):
	print(direction)
	var tween = create_tween()
	tween.tween_property(self,'global_position',global_position+60*direction,0.5)
	await tween.finished
	queue_free()
