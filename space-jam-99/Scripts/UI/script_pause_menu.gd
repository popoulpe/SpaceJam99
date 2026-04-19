extends Control
var paused = false

@export var _Audio : Control
@export var _AudioSkateTexture : TextureRect
@export var _Pause : Control
var hue : float = 0.0
@export var _position : Array[Vector2]=[Vector2(0,0),Vector2(0,0)]
@export var fspeed:float=5.0

func _ready() -> void:
	_position[0] = _Pause.position
	_position[1] = _AudioSkateTexture.position
	hide()
	paused = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		_pauseMenu()
	_on_timer_timeout(delta)

func _pauseMenu()->void:
	if(paused):
		get_tree().paused = false
		hide()
		#visible = false
		#Input.mouse_mode = Input.MOUSE_MODE_CONFINED_HIDDEN
	else:
		get_tree().paused = true
		show()
		_Audio.hide()
		_Pause.show()
		visible = true
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	paused=!paused
	print(paused)

func _on_start_texture_button_pressed() -> void:
	_pauseMenu()

func _on_quit_texture_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/MainScenes/scene_main_menu.tscn")

func _on_timer_timeout(f:float):
	hue += 0.7 * f
	if hue >= 1.0:
		hue = 0.0
	var angle: float = hue * TAU
	var r: float = (sin(angle)*0.5)+0.5
	var g:float = (sin(angle + TAU /3)*0.5)+0.5
	
	_Pause.scale = Vector2(1+r/30,1+r/30)
	_Pause.position = _position[0] + Vector2(r,g)*fspeed
	_AudioSkateTexture.scale = Vector2(1+r/30,1+r/30)
	_AudioSkateTexture.position = _position[1] + Vector2(r,g)*fspeed

func _on_option_button_pressed() -> void:
	_Pause.hide()
	_Audio.show()

func _on_back_texture_button_pressed() -> void:
	_Audio.hide()
	_Pause.show()
