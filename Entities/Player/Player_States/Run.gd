extends State

var max_speed :int = 150
var acceleration:int = 95

func do():
	super()
	animation_direction_calculator()
	
func physics_do(delta):
	super(delta)
	input_vector.x = Input.get_axis("ui_left","ui_right")
	body.velocity = body.velocity.move_toward(Vector2(input_vector.x,0)*max_speed,acceleration)
	body.move_and_slide()

func animation_direction_calculator():
	if input_vector.x >=0:
		animation_player.play("Run_Standard_E")
	else:
		animation_player.play("Run_Standard_W")
