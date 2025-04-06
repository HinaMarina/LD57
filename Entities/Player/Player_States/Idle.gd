extends State


func set_input_vector(new_value:Vector2):
	super(new_value)
		

func _ready():
	super()
		
func do():
	super()
	animation_direction_calculator()

		
func physics_do(delta):
	body.velocity = body.velocity.move_toward(Vector2.ZERO,200)
	body.move_and_slide()
	
func enter():
	super()

func animation_direction_calculator():
	if is_holding_girl:
		if input_vector.x >=0:
			animation_player.play("Idle_with_girl_E")
		else:
			animation_player.play("Idle_with_girl_W")
	else:		
		if input_vector.x >=0:
			animation_player.play("Idle_Standard_E")
		else:
			animation_player.play("Idle_Standard_W")
