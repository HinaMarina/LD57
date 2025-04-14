extends State

@export var jump_height:float
@export var peak_time:float
@export var fall_time:float

@onready var jump_velocity:float =(-1)*(2*jump_height)/peak_time
@onready var jump_gravity:float = (-1)*(-2*jump_height)/(peak_time*peak_time)
@onready var fall_gravity:float = (-1)*(-2*jump_height)/(fall_time*fall_time)

@export var jumpFX:AudioStreamPlayer2D
var jump_sounded:bool = false
var coyote_time:float = 0.13

var already_jumped:bool = false

func enter():
	super()
	jump_sounded = false
	already_jumped = false

	
func get_gravity():
	return fall_gravity


func do(delta):
	super(delta)
	play_animation()
	


func physics_do(delta):

	body.velocity.y += get_gravity()*delta
	body.velocity.x = Input.get_axis("ui_left","ui_right")*120
	body.move_and_slide()
	

func play_animation():
	if get_gravity() == fall_gravity:
		if input_vector.x>=0:
			if lambda_time() < peak_time + fall_time/1.5:
				animation_player.play("Jump_Standard_DOWN_E_Frame1")
			else:
				animation_player.play("Jump_Standard_DOWN_E_Frame2")
		else:
			if lambda_time() < peak_time + fall_time/1.5:
				animation_player.play("Jump_Standard_DOWN_W_Frame1")
			else:
				animation_player.play("Jump_Standard_DOWN_W_Frame2")
