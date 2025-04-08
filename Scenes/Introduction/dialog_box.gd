extends MarginContainer

@export var label :Label
@export var letter_timer:Timer

const box_max_width = 150

var text := ""
var letter_index:=0

var letter_time = 0.03
var space_time = 0.06
var special_characters_time = 0.2

signal finished_to_display()

func to_display(new_text: String):
	text = new_text
	label.text = new_text
	await  resized
	custom_minimum_size.x = min(size.x,box_max_width)
	
	if size.x > box_max_width:
		label.autowrap_mode = TextServer.AUTOWRAP_WORD
		
		await resized
		await resized
		custom_minimum_size.y = size.y
		
	global_position.x -= size.x/2
	global_position.y -= size.y + 24
	
	label.text = ""
	display_letter()

func display_letter():
	
	label.text += text[letter_index]
	letter_index += 1
	if letter_index == text.length():
		finished_to_display.emit()
		return
	
	match text[letter_index]:
		".","?","!",",":
			letter_timer.start(special_characters_time)
		" ":
			letter_timer.start(space_time)
		_:
			letter_timer.start(letter_time)
			
	
	

func _on_letter_timer_timeout() -> void:
	display_letter()
