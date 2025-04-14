class_name State_Machine extends State

@export var Idle_State :State
@export var Run_State :State
@export var Walking_State :State
@export var Jump_Standard_State :State
@export var Jump_withgirl_State :State
@export var Fall_State:State
@export var Fall_State_Withgirl:State
@export var Shoot_State :State
@export var Death_State :State
@export var Collision_Shape :CollisionShape2D

@export var shot_spot:Node2D
var can_shoot:=true

var coyote_time:float = 0.15

func _ready() -> void:
	super()
	set_state(Idle_State)
	PlayerDeathManager.is_teleporting.connect(teleporting_change)

func _process(delta: float) -> void:
	print(current_state)
	if is_teleporting:
		return
	grounded = body.is_on_floor()
	if is_instance_valid(current_state):
		current_state.do(delta)
	if current_state == Death_State:
		return
	select_state()
	

	
func _physics_process(delta: float) -> void:
	if is_teleporting:
		return

	if is_instance_valid(current_state):
		current_state.physics_do(delta)

func select_state():
	
	if ((current_state == Fall_State || current_state == Fall_State_Withgirl)
	&& current_state.lambda_time() <= coyote_time
	&& Input.is_action_just_pressed("Jump")
	
	):
	
		if is_holding_girl:
			set_state(Jump_withgirl_State)
		else:
			set_state(Jump_Standard_State)
		return
			
	if !grounded && can_player_move && current_state!= Jump_Standard_State && current_state!= Jump_withgirl_State:
		if is_holding_girl:
			set_state(Fall_State_Withgirl)
		else:
			set_state(Fall_State)
		return
		
	if Input.is_action_just_pressed("Jump") && can_player_move && grounded && !Input.is_action_pressed("ui_down"):
		if is_holding_girl:
			set_state(Jump_withgirl_State)
		else:
			set_state(Jump_Standard_State)
		return
		
	if !Input.is_action_pressed("Movement_action") && can_player_move && grounded:
		set_state(Idle_State)
		return
		
	elif Input.is_action_pressed("Movement_action") && can_player_move && grounded:
		if is_holding_girl:
			set_state(Walking_State)
		else:
			set_state(Run_State)
	
	
			

func _input(event: InputEvent) -> void:

			
	if Input.is_action_pressed("ui_down") && current_state == Idle_State:
		if Input.is_action_just_pressed("Jump"):
			Collision_Shape.set_deferred("disabled",true)
			await get_tree().create_timer(0.1).timeout
			Collision_Shape.set_deferred("disabled",false)
	
	if Input.is_action_pressed("Movement_action"):
		if can_player_move:
			var playerinput :Vector2
			playerinput.x = Input.get_axis("ui_left","ui_right")
			playerinput.y = Input.get_axis("ui_up","ui_down")
			set_input_vector(playerinput.normalized())
	if Input.is_action_just_pressed("Shoot") && can_player_move && can_shoot && !is_holding_girl:
		can_shoot = false
		set_state(Shoot_State)
		can_player_move = false
		await get_tree().create_timer(0.7).timeout
		can_shoot = true
	

func take_damage():
	set_state(Death_State)
	current_state.do(0.0) 

func teleporting_change(value:bool):
	is_teleporting = value
