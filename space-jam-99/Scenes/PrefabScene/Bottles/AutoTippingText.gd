extends TextureRect

# Configuration
@export var full_text: String = ""
@export var label_full_text: Label
@export var typing_speed: float = 0.05  
@export var space_speed: float = 0.15
@export var punctuation_speed: float = 0.20
var current_index: int = 0
@export var is_typing: bool = false
@export var onStart: bool = false
var timer: Timer
@export var _text: Label
var punctuation_chars: Array = [",", ".", "!", "?", ":", ";", "…", "!", "?", "…"]

func _ready():
	if not is_instance_valid(label_full_text):
		push_warning("_text is not connected in the inspector.")
		return
		
	timer = Timer.new()
	timer.wait_time = typing_speed
	timer.one_shot = false
	timer.timeout.connect(_on_typing_timeout)
	add_child(timer)
	
	if(onStart):
		start_typing()

func start_typing():
	if not is_instance_valid(label_full_text):
		return
	var text_to_type = label_full_text.text if label_full_text.text != "" else full_text
	if text_to_type == "":
		print("No text to type.")
		return
	full_text = text_to_type
	current_index = 0
	is_typing = true
	_text.text = ""
	if not is_instance_valid(_text):
		print("Error: _text is not assigned.")
		return
	timer.start()

func start_dialogue(text: String):
	full_text = text
	start_typing()

func _on_typing_timeout():
	if not is_instance_valid(_text):
		return
	if is_typing:
		if current_index < full_text.length():
			var current_char = full_text[current_index]
			var current_wait_time = typing_speed
			if current_char == " ":
				current_wait_time = space_speed
			elif current_char in punctuation_chars:
				current_wait_time = punctuation_speed
			timer.wait_time = current_wait_time
			_text.text = full_text.substr(0, current_index + 1) + "|"
			current_index += 1
		else:
			is_typing = false
			_text.text = full_text
			timer.stop()
