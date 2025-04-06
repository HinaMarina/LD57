extends CharacterBody2D


var max_speed :int = 100
var acceleration:int = 75
var input_vector:=Vector2.ZERO
@export var animation_player:AnimationPlayer

var player_can_move:=true

func _physics_process(delta: float) -> void:
	movement()
		
func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_pressed("movement_action"):
		if player_can_move:
			input_vector.x = Input.get_axis("ui_left","ui_right")
	if Input.is_action_just_released("movement_action"):
			input_vector = Vector2.ZERO	
			
func movement():
	velocity = velocity.move_toward(max_speed*input_vector,acceleration)
	if input_vector.x>0:
		animation_player.play("Run_Standard_E")
	elif input_vector.x<0:
		animation_player.play("Run_Standard_W")
	else:
		animation_player.stop()
	move_and_slide()
