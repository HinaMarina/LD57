extends nightmare


@export var raycastleft:RayCast2D
@export var raycastright:RayCast2D
@export var body:StaticBody2D
@export var animator:AnimationPlayer

var idle_amount:= 0
func _ready() -> void:
	animator.play('IDLE')
	
func _process(delta: float) -> void:
	if animator.current_animation == "SHOOT":
		return
	if raycastleft.is_colliding():
		var collider = raycastleft.get_collider()
		if collider is Player:
			body.scale.x = 1.0
	if raycastright.is_colliding():
		var collider = raycastright.get_collider()
		if collider is Player:
			body.scale.x = -1.0


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		if body.has_method("take_damage"):
			body.take_damage()


func _on_area_2d_2_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		if body.has_method("take_damage"):
			body.take_damage()


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "IDLE":

		idle_amount +=1
		if idle_amount >=3:
			animator.play("SHOOT")
			return
		animator.play("IDLE")
	elif anim_name == "SHOOT":
		idle_amount = 0
		animator.play("IDLE")
