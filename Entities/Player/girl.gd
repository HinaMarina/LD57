extends Node2D

var input_vector:Vector2 = Vector2.ZERO
@export var area:Area2D
@export var animationPlayer:AnimationPlayer
var playerbody:CharacterBody2D
var can_pick:=false

func _ready() -> void:
	area.monitoring = false
	if input_vector.x>=0:
		animationPlayer.play("Sit_E")
	else:
		animationPlayer.play("Sit_W")


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	area.monitoring = true

func _on_area_2d_area_entered(area: Area2D) -> void:
	can_pick = true

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		can_pick = true
		playerbody = body

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body is CharacterBody2D:
		can_pick = false
		playerbody = null
		
func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_released("Pick_Girl") && can_pick:
		if playerbody.has_method("pick_girl"):
			playerbody.pick_girl()
			var viewport = get_viewport()
			viewport.set_input_as_handled()
			queue_free()
