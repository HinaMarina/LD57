class_name State_Machine extends State

@export var Idle_State :State
@export var Run_State :State
@export var Walking_State :State
@export var Jump_Standard_State :State
@export var Jump_withgirl_State :State
@export var Shoot_State :State

@export var shot_spot:Node2D
var is_shooting := false
func _ready() -> void:
	super()
	set_state(Idle_State)


func _process(delta: float) -> void:
	grounded = body.is_on_floor()

	current_state.do()
	select_state()
	

	
func _physics_process(delta: float) -> void:
	if !grounded && can_player_move:
		if is_holding_girl:
			set_state(Jump_withgirl_State)
		else:
			set_state(Jump_Standard_State)
	current_state.physics_do(delta)

func select_state():
	if !Input.is_action_pressed("Movement_action") && can_player_move && grounded:
		set_state(Idle_State)
	elif Input.is_action_pressed("Movement_action") && can_player_move && grounded:
		if is_holding_girl:
			set_state(Walking_State)
		else:
			set_state(Run_State)
	if Input.is_action_just_pressed("ui_accept") && can_player_move && grounded:
		if is_holding_girl:
			set_state(Jump_withgirl_State)
		else:
			set_state(Jump_Standard_State)

func _input(event: InputEvent) -> void:
	if Input.is_action_pressed("Movement_action"):
		if can_player_move:
			var playerinput :Vector2
			playerinput.x = Input.get_axis("ui_left","ui_right")
			playerinput.y = Input.get_axis("ui_up","ui_down")
			set_input_vector(playerinput.normalized())
	if Input.is_action_just_pressed("Shoot") && can_player_move:
		set_state(Shoot_State)
		can_player_move = false
		
