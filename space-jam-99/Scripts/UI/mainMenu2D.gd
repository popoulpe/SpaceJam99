extends Control

@export var hud_pause_menu: Control 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hud_pause_menu= $"../HudPauseMenu"
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_start_texture_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/MainScenes/definitiveScene/ScientifeetShip.tscn")
	#var iInt: int = randi() % 2
	#hud_pause_menu.AudioManager.play_ui_sfx(hud_pause_menu.AudioManager._ui_button[iInt])

func _on_quit_texture_button_pressed() -> void:
	get_tree().quit()
	var iInt: int = randi() % 2
	hud_pause_menu.AudioManager.play_ui_sfx(hud_pause_menu.AudioManager._ui_button[iInt])

func _on_options_texture_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/MainScenes/definitiveScene/SceneCreditsWithShip.tscn")
	var iInt: int = randi() % 2
	hud_pause_menu.AudioManager.play_ui_sfx(hud_pause_menu.AudioManager._ui_button[iInt])
