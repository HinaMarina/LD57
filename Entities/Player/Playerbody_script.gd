class_name Player extends CharacterBody2D

@export var _Machine:State_Machine
@export var girlscene:PackedScene
@export var soundfx:AudioStreamPlayer2D

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_released("Pick_Girl") && _Machine.is_holding_girl && is_on_floor():
		leave_girl()
		var viewport = get_viewport()
		viewport.set_input_as_handled()

func pick_girl():
	_Machine.is_holding_girl = true
	
func leave_girl():
	soundfx.play()
	var girl = girlscene.instantiate()  as Node2D
	girl.input_vector = _Machine.input_vector
	var parent = get_parent().get_parent()
	parent.add_child(girl)
	girl.global_position = self.global_position - _Machine.input_vector*15

	_Machine.is_holding_girl = false

func take_damage():
	_Machine.take_damage()
