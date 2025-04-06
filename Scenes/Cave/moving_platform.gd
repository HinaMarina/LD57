extends Node2D

@export var time_to_move:float = 3.0
@export var timer:Timer
@export var animator:AnimationPlayer

func _ready() -> void:
	animator.play("path")
	animator.speed_scale = animator.speed_scale/time_to_move
