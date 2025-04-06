extends State

@export var jump_height:float
@export var peak_time:float
@export var fall_time:float

@onready var jump_velocity:float =(-1)*(2*jump_height)/peak_time
@onready var jump_gravity:float = (-1)*(-2*jump_height)/(peak_time*peak_time)
@onready var fall_gravity:float = (-1)*(-2*jump_height)/(fall_time*fall_time)

var coyote_time:float = 0.05


func get_gravity():
	return jump_gravity if body.velocity.y<0 else fall_gravity
	
func jump():
	body.velocity.y = jump_velocity

func do():
	if lambda_time() <= coyote_time && Input.is_action_just_pressed("Jump"):
		jump()
	super()
	play_animation()
	
func physics_do(delta):
	body.velocity.y += get_gravity()*delta
	body.velocity.x = Input.get_axis("ui_left","ui_right")*90
	if grounded:
		jump()
	body.move_and_slide()

func play_animation():
	if get_gravity() == jump_gravity:
		if input_vector.x>=0:
			animation_player.play("Jump_withgirl_UP_E")
		else:
			animation_player.play("Jump_withgirl_UP_W")
	if get_gravity() == fall_gravity:
		if input_vector.x>=0:
			animation_player.play("Jump_withgirl_DOWN_E")
			
		else:
			animation_player.play("Jump_withgirl_DOWN_W")
			
