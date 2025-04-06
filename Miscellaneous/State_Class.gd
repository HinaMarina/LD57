class_name State extends Node2D

@export_category("General Assets")
@export var animation_player:AnimationPlayer
#@export var State_Machine:State_Machine
@export var body:CharacterBody2D
@export var player_gaze:RayCast2D


@onready var state_sprite:Sprite2D

var last_animation:StringName

var is_complete:bool = false
var start_time : float = 0.0
var all_children_states:Array[State]
var parent_state:State
var current_state:State

var grounded:=true:
	set(new_value):
		if new_value != grounded:
			grounded = new_value
			for child in all_children_states:
				child.grounded = new_value

var is_holding_girl:=false:
	set(new_value):
		if new_value != is_holding_girl:
			is_holding_girl = new_value
			for child in all_children_states:
				child.is_holding_girl = new_value

var can_player_move:bool = true:
	set(new_value):
		if new_value != can_player_move:
			can_player_move = new_value
			for child in all_children_states:
				child.can_player_move = new_value
				
var input_vector:Vector2


func set_input_vector(new_value:Vector2):
	if input_vector != new_value:
		input_vector = new_value
		for state in all_children_states:
			state.set_input_vector(input_vector)
			

func _ready() -> void:
	set_state_assets()
	var parent_node = self.get_parent()
	if parent_node is State:
		parent_state = parent_node	
		
func lambda_time():
	return (Time.get_ticks_msec() - start_time)/1000
	
func set_state(new_state:State,force_reset:bool = false):
	if new_state == null:
		return
	if new_state != current_state || force_reset:
		if current_state != null:			
			current_state.complete()
			
		current_state = new_state
		#current_state.initialize()
		current_state.enter()
		#hide_other_state_sprites()

func initialize():
	current_state.visible = true
	hide_other_state_sprites()

func enter():
	start_time = Time.get_ticks_msec()
	is_complete = false
	
	if current_state != null:
		current_state.enter()
	
func complete():
	if current_state != null:
		current_state.complete()
	is_complete = true


func do():
	if current_state != null and current_state.is_complete == false:
		current_state.do()
	
	#var animation_machine = animation_tree.get("parameters/playback") as AnimationNodeStateMachinePlayback
	#var nodestate_machine = animation_tree.tree_root.get_node(animation_machine.get_current_node())
	#if nodestate_machine is AnimationNodeStateMachine:
		#var nodestate_machine_name:= animation_machine.get_current_node()
		#var path = "parameters/"+nodestate_machine_name+"/playback"
		#var nodestate_machine_playback = animation_tree.get(path) as AnimationNodeStateMachinePlayback
		#print(nodestate_machine_playback.get_current_node())
	#else:
		#print()
	
	
func physics_do(delta):
	if current_state!= null and current_state.is_complete == false:
		current_state.physics_do(delta)
	
	
func hide_other_state_sprites():
	for state in all_children_states:
		
		if state.state_sprite == null:
			continue
			
		if state != current_state:
			state.state_sprite.visible = false
		else:
			state.state_sprite.visible = true
			
			
func set_state_assets():
	for child in self.get_children():
		if child is Sprite2D:
			state_sprite = child
		elif child is State:
			all_children_states.append(child)
	if animation_player != null:
		animation_player.animation_started.connect(on_animation_started)
			
func pause_movement(value:bool):
	can_player_move = value
	
func on_animation_started(anim_name:StringName):
	var animation = animation_player.get_animation(animation_player.get_current_animation())
	var path = animation.track_get_path(0)
	
	var node = body.get_node(path)
	for each in all_children_states:
		if each.state_sprite == null:
			continue
		if each.state_sprite != node:
			each.state_sprite.visible = false
		else:
			each.state_sprite.visible = true
