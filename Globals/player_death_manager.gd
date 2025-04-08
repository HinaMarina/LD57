extends Node2D

@onready var last_saved_spot:Vector2
@onready var last_scene_saved:String

@onready var playerCamera:Camera2D
@export var player_packed_scene:PackedScene
@export var girl_scene:PackedScene

@export var animator:AnimationPlayer
@export var canvas:CanvasLayer
@export var transitioncanvas:CanvasLayer
@export var spill_sprite:Sprite2D
@export var spill_animator:AnimationPlayer

var scene_to_transit:String
var point_to_go:Vector2
var player_to_transit:player_node

signal player_is_dead



func _ready() -> void:
	spill_sprite.visible = false

func save_position(position:Vector2,scenepath:String):
	last_saved_spot = position
	last_scene_saved = scenepath
	
func save_player_camera(camera:Camera2D):
	playerCamera = camera
	
func player_died():
	if last_scene_saved == null:
		instantiate_player()
		return
	if playerCamera.has_method("shake"):
		playerCamera.shake(2)
	var player = player_packed_scene.instantiate()
	var girl = girl_scene.instantiate()
	
	var scene = load(last_scene_saved)
	animator.play("fade_in")
	await animator.animation_finished
	if is_instance_valid(playerCamera):
		playerCamera.queue_free()
	if get_tree().get_current_scene() == scene:
		get_tree().unload_current_scene()
	get_tree().call_deferred("change_scene_to_packed", scene)
	canvas.visible = true
	await Engine.get_main_loop().process_frame
	await Engine.get_main_loop().process_frame
	
	
	var current_scene = get_tree().get_current_scene()
	current_scene.add_child(player)
	current_scene.add_child(girl)
	player.global_position = last_saved_spot
	girl.global_position = last_saved_spot

	set_player_camera(player,current_scene,false)
		
	animator.play("fade_out")
	await animator.animation_finished

func instantiate_player():
		
		var current_scene = get_tree().get_current_scene() as stage_level
		var player = player_packed_scene.instantiate() as player_node
		var girl = girl_scene.instantiate()
		current_scene.add_child(player)
		current_scene.add_child(girl)
		player.global_position = current_scene.player_initial_spot
		girl.global_position = current_scene.player_initial_spot

		set_player_camera(player,current_scene,false)
		
func _input(event: InputEvent) -> void:
	if Input.is_action_just_released("instantiate_player"):
		instantiate_player()
		
func change_scene(target_position:Vector2,target_scene:String,player:player_node):
	player.call_deferred('reparent',self)
	scene_to_transit = target_scene
	point_to_go = target_position
	player_to_transit = player
	animator.play("transition")



func transit_to():

	var scene = load(scene_to_transit)
	get_tree().call_deferred("change_scene_to_packed", scene)
	await Engine.get_main_loop().process_frame
	await Engine.get_main_loop().process_frame
	var current_scene = get_tree().get_current_scene()
	player_to_transit.call_deferred('reparent',current_scene)
	player_to_transit.body.global_position = point_to_go

	set_player_camera(player_to_transit,current_scene,true)
	
	
	
func set_player_camera(player:player_node,current_scene:stage_level,is_portal:bool):		
	if current_scene.camera_limit_diagonal_left == null || current_scene.camera_limit_diagonal_right == null:
		return
	player.Camera.limit_bottom = current_scene.camera_limit_diagonal_left.global_position.y
	player.Camera.limit_left = current_scene.camera_limit_diagonal_left.global_position.x
	player.Camera.limit_right = current_scene.camera_limit_diagonal_right.global_position.x
	player.Camera.limit_top = current_scene.camera_limit_diagonal_right.global_position.y
	
	await animator.animation_finished
	if is_portal:
		player.body._Machine.can_player_move = false
		spill_sprite.global_position = player.body.global_position + Vector2(0,-25)
		spill_animator.play_backwards("Spill")
		print('oi')

		await spill_animator.animation_finished
	
		player.body.global_position = player.body.global_position+Vector2(0,-15)
		player.body.visible = true
	if is_instance_valid(player):
		player.body._Machine.can_player_move = true


#func spill_player():
	#player_to_transit.body.visible = true
		
