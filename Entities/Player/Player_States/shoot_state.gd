extends State

@export var spiritual_shot_scene:PackedScene
@export var shot_spot:Node2D
func _ready() -> void:
	super()
	animation_player.animation_finished.connect(on_animation_finished)
	
func shoot():
	shot_spot.global_position.x = body.global_position.x + input_vector.x*20
	var spiritual_shot = spiritual_shot_scene.instantiate()
	var parent = body.get_parent().get_parent()
	parent.add_child(spiritual_shot)
	spiritual_shot.global_position = shot_spot.global_position
	spiritual_shot.shoot(input_vector)

func do():
	if input_vector.x>=0:
		animation_player.play("Spiritual_Shot_E")
	else:
		animation_player.play("Spiritual_Shot_W")

func physics_do(delta):
	if grounded || body.velocity.y>=0:
		body.velocity = body.velocity/2
		body.move_and_slide()
		
func on_animation_finished(anim_name):
	var parent = get_parent() as State_Machine
	parent.can_player_move = true
