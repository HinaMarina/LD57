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
	body.velocity.x = Input.get_axis("ui_left","ui_right")*90
	body.move_and_slide()
	

func play_animation():
	if get_gravity() == fall_gravity:

		if input_vector.x>=0:
			animation_player.play("Jump_withgirl_DOWN_E")
			
		else:
			animation_player.play("Jump_withgirl_DOWN_W")
			
