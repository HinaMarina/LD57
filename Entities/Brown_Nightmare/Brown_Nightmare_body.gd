extends CharacterBody2D


func get_damage():
	get_parent().queue_free()
