extends Node2D
@export var bg_anim:AnimatedSprite2D
@export var mouth_anim:AnimatedSprite2D
@export var target_scene:String
@export var target_position:Vector2
@export var soundFX:AudioStreamPlayer2D
var body_captured:Player
var teleport:=true
var started:= false

func _ready() -> void:
	mouth_anim.visible = false
	bg_anim.visible = true
func _process(delta: float) -> void:
	if mouth_anim.is_playing():
			body_captured.visible = false
	
	if mouth_anim.frame == 6 && teleport:
		PlayerDeathManager.change_scene(target_position,target_scene,body_captured.get_parent())
		teleport = false
	
		
func _on_area_2d_body_entered(body: Node2D) -> void:
	if started:
		return
	if body is Player:
	
		if body._Machine.is_holding_girl:
			soundFX.play()
			started = true
			body.velocity = Vector2.ZERO
			body.global_position = self.global_position
			body_captured = body
			mouth_anim.visible = true
			bg_anim.play("Getting_in")
			mouth_anim.play("Eating")
		
