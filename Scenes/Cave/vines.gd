extends StaticBody2D

@export var animator :AnimationPlayer
@export var sprite:Sprite2D
var life = 3

func _ready() -> void:
	sprite.frame = 0

func get_damage():
	life -= 1
	if sprite.frame >= 1:
		animator.play("Dies")
		return
	sprite.frame += 1
	
	


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	queue_free()
