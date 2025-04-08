extends Node


@onready var dialog_box_scene = preload("res://Scenes/Introduction/dialog_box.tscn")

var _lines:Array[String] = []
var current_line_index = 0

var text_box
var text_box_position:Vector2

var is_dialog_active := false
var can_advance_line := false

func start_talk(box_position:Vector2,text_lines:Array[String]):
	if is_dialog_active:
		return
	_lines = text_lines
	text_box_position = box_position
	
	show_box()
	is_dialog_active = true
	
func show_box():
	var text_box = dialog_box_scene.instantiate()
	text_box.finished_to_display.connect(on_text_box_finished_to_display)
	
	get_tree().root.add_child(text_box)
	text_box.global_position = text_box_position
	text_box.to_display(_lines[current_line_index])
	can_advance_line = false
	
	
func on_text_box_finished_to_display():
	can_advance_line = true
	
func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("advance_dialog") && is_dialog_active && can_advance_line:
		text_box.queue_free()
		current_line_index +=1
		if current_line_index >= _lines.size():
			current_line_index =0
			is_dialog_active = false
			return
		show_box()
