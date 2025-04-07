extends CharacterBody2D

func get_damage():
	get_parent().queue_free()

func _physics_process(delta: float) -> void:
	if !is_on_floor():
		velocity.y += 100
		move_and_slide()
