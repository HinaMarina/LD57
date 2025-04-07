extends Node2D
@export var curveanimator:AnimationPlayer
@export var spriteanimator:AnimationPlayer
@export var body:CharacterBody2D
@export var sprite:Sprite2D
@export var path2d:Path2D
@export var follow:PathFollow2D
@export var inversion:bool = false

var can_flip:=true


func _process(delta: float) -> void:
	if !body.is_on_floor():
		curveanimator.stop()

	if !curveanimator.is_playing() && body.is_on_floor():
		if inversion:
			curveanimator.play("Pathprogress_inverse")
		else:
			curveanimator.play("Pathprogress")
		
	path2d.global_position.y = body.global_position.y

	
	
	
func _ready() -> void:
	if inversion:
			curveanimator.play("Pathprogress_inverse")
	else:
		curveanimator.play("Pathprogress")
	spriteanimator.play("Walk")


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		if body.has_method("take_damage"):
			body.take_damage()
