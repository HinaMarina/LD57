extends Node2D

var max_speed := 200.0
var acceleration := 100.0

@export var body:CharacterBody2D
@export var left_limit:Node2D
@export var right_limit:Node2D
@export var animator:AnimationPlayer
@export var timer:Timer
var direction :Vector2
var is_moving:=false
enum state {Idle,Patrol}
var last_point:Vector2

func _physics_process(delta: float) -> void:
	if !body.is_on_floor():
		body.velocity.y += 100
		
	body.move_and_slide()
	if body.global_position.distance_to(last_point) <=3:
		body.velocity = Vector2.ZERO
		is_moving = false
		
func go_to(point:Vector2):
	point.y =  body.global_position.y
	#if point.distance_to(last_point) <= (right_limit.global_position.x - left_limit.global_position.x):
		#var max_dist = max(point.distance_to(left_limit.global_position),point.distance_to(right_limit.global_position))
		#if max_dist ==  point.distance_to(left_limit.global_position):
			#point.x = left_limit.global_position.x
		#elif max_speed == point.distance_to(right_limit.global_position):
			#point.x = right_limit.global_position.x
		
	is_moving = true
	direction = body.global_position.direction_to(point).normalized()
	direction.y = 0
	if direction.x >= 0:
		animator.play("Patrol_E")
		point.x = right_limit.global_position.x
	else:
		animator.play("Patrol_W")
		point.x = left_limit.global_position.x
	last_point = point

	body.velocity = body.velocity.move_toward(direction*max_speed,acceleration)
	

#func _process(delta: float) -> void:
	#if body.velocity == Vector2.ZERO:
		#timer.start(1)

func decide_next_state():
	var next_state = randi_range(0,1)
	var future_state = state.find_key(next_state)
	if future_state == "Idle":
		if direction.x >=0:
			animator.play("IDLE_E")
		else:
			animator.play("IDLE_W")
			
	elif future_state == "Patrol":
		var randomX = randf_range(left_limit.global_position.x,right_limit.global_position.x)
		go_to(Vector2(randomX,0))


func _on_timer_timeout() -> void:
	timer.start(1)
	decide_next_state()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		if body.has_method("take_damage"):
			body.take_damage()
