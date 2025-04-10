extends State
@export var soundFX:AudioStreamPlayer2D
var is_dead:=false

func _ready() -> void:
	super()
	animation_player.animation_finished.connect(on_animation_finished)

func do():
	die()
	
func die():
	if is_dead:
		return
	is_dead = true
	var state_machine = get_parent()
	state_machine.can_player_move = false
	soundFX.play()
	if is_holding_girl:
		animation_player.play("Death_Anim_withgirl")
	else:
		animation_player.play("Death_Anim")
	Camera.position_smoothing_enabled = false
	Camera.shake(2.0)

func on_animation_finished(anim_name:StringName):
	if anim_name == "Death_Anim_withgirl" || anim_name == "Death_Anim":
		PlayerDeathManager.player_died()
		Camera.reparent(get_tree().root)
		body.get_parent().queue_free()
		
