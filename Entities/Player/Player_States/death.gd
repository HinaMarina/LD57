extends State

func _ready() -> void:
	super()
	animation_player.animation_finished.connect(on_animation_finished)

func do():
	die()
	
func die():
	var state_machine = get_parent()
	state_machine.can_player_move = false
	if is_holding_girl:
		animation_player.play("Death_Anim_withgirl")
	else:
		animation_player.play("Death_Anim")

func on_animation_finished(anim_name:StringName):
	if anim_name == "Death_Anim_withgirl" || anim_name == "Death_Anim":
		Camera.reparent(get_tree().root)
		Camera.enabled = true
		body.get_parent().queue_free()
