extends Node2D
@export var animationPlayer:AnimationPlayer
@export var next_scene_path:String
var next_anim:String = " "
var can_advance:bool=false

func _ready():
	animationPlayer.play("text_1")
func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "wait":
		can_advance = true
		next_anim = 'text_1'
	elif anim_name == "text_1":
		can_advance = true
		next_anim = 'text_2'
	elif anim_name == "text_2":
		can_advance = true
		next_anim = 'text_3'
	elif anim_name == "text_3":
		can_advance = true
		next_anim = 'fade_out'
	elif anim_name == "fade_out":
		await get_tree().create_timer(5).timeout
		var scene = load(next_scene_path)
		get_tree().call_deferred("change_scene_to_packed", scene)

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("advance_dialog"):
		if can_advance:
			animationPlayer.play(next_anim)
			
