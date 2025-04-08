extends nightmare
var target:CharacterBody2D
var speed:=100
var can_fly:bool=false
@export var mybody:CharacterBody2D


	
func _physics_process(delta: float) -> void:
	mybody.move_and_slide()
	if can_fly == true:		
		var direction = mybody.global_position.direction_to(target.global_position)
		mybody.velocity = mybody.velocity.move_toward(direction*speed,speed/100)


func _on_detection_area_body_entered(body: Node2D) -> void:
	if body is Player:
		target = body
		
		can_fly = true
		
	


func _on_hitbox_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		if body.has_method("take_damage"):
			body.take_damage()


func _on_detection_area_body_exited(body: Node2D) -> void:
	if mybody.velocity != Vector2.ZERO:
		mybody.velocity = Vector2.ZERO
		can_fly = false
		
