extends RichTextLabel

@export var full_text: String = ""
@export var typing_speed: float = 0.05  
@export var space_speed: float = 0.15
@export var punctuation_speed: float = 0.20
@export var fade_in_duration: float = 0.3  # Renommé pour plus de clarté

var current_index: int = 0
var is_typing: bool = false
var timer: Timer
var fade_timer: Timer
var punctuation_chars: Array = [",", ".", "!", "?", ":", ";", "…"]

var char_animation_state: Array = [] 

const NORMAL_SIZE: int = 28

func _ready():
	timer = Timer.new()
	timer.wait_time = typing_speed
	timer.one_shot = false
	timer.timeout.connect(_on_typing_timeout)
	add_child(timer)

	fade_timer = Timer.new()
	fade_timer.wait_time = 0.02
	fade_timer.one_shot = false
	fade_timer.timeout.connect(_on_fade_tick)
	add_child(fade_timer)

	if is_autostart:
		start_typing()

func _input(event):
	if event is InputEventMouseButton and event.pressed:
		if is_typing:
			_finish_immediately()

func start_typing():
	if full_text == "":
		print("No text to type.")
		return

	full_text = full_text.strip_edges()
	current_index = 0
	is_typing = true
	char_animation_state.clear()
	text = ""
	fade_timer.stop()
	timer.start()

func start_dialogue(newText: String):
	full_text = newText
	start_typing()

func _on_typing_timeout():
	if current_index < full_text.length():
		var current_char = full_text[current_index]
		var current_wait_time = typing_speed
		
		if current_char == " ":
			current_wait_time = space_speed
		elif current_char in punctuation_chars:
			current_wait_time = punctuation_speed
		
		timer.wait_time = current_wait_time

		var bbcode = "[font_size=%d][color=#00000000]%s[/color][/font_size]" % [NORMAL_SIZE, current_char]
		text += bbcode

		char_animation_state.append({
			"alpha": 0,
			"start_time": Time.get_ticks_msec()
		})

		if fade_timer.is_stopped():
			fade_timer.start()
		
		current_index += 1
	else:
		is_typing = false
		timer.stop()

func _on_fade_tick():
	if char_animation_state.size() == 0:
		return

	var new_text = ""
	var now = Time.get_ticks_msec()
	var all_done = true
	for i in range(char_animation_state.size()):
		var state = char_animation_state[i]
		var elapsed = (now - state.start_time) / 1000.0
		var _char = full_text[i]

		if elapsed < fade_in_duration:
			all_done = false
			var progress = elapsed / fade_in_duration
			
			var current_alpha = int(lerp(0, 255, progress))
			
			var color_hex = "%02x%02x%02x%02x" % [0, 0, 0, current_alpha]
			
			var bbcode = "[font_size=%d][color=#%s]%s[/color][/font_size]" % [NORMAL_SIZE, color_hex, _char]
			new_text += bbcode
		else:
			var bbcode = "[font_size=%d][color=#000000]%s[/color][/font_size]" % [NORMAL_SIZE, _char]
			new_text += bbcode

	text = new_text

	if all_done:
		fade_timer.stop()

func _finish_immediately():
	text = full_text
	is_typing = false
	timer.stop()
	fade_timer.stop()
	char_animation_state.clear()

@export var is_autostart: bool = false
