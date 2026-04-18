extends Control
class_name ui_hud_minijeux

@onready var panel_interact = $interaction
@onready var mini_jeux = $MiniJeux

func show_interact_ui():
	visible = true
	if mini_jeux.visible:
		Input.mouse_mode =Input.MOUSE_MODE_VISIBLE

func hide_interact_ui():
	visible = false
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN

func interact(MiniJeuxName:String) -> void:
	var tween = get_tree().create_tween()
	tween.tween_property(panel_interact, "scale", Vector2(0.8,0.8), 0.25).set_trans(Tween.TRANS_ELASTIC)
	tween.tween_property(panel_interact, "scale", Vector2(1.05,1.05), 0.2).set_trans(Tween.TRANS_ELASTIC)
	tween.tween_property(panel_interact, "scale", Vector2(1,1), 0.1).set_trans(Tween.TRANS_ELASTIC)
	tween.tween_callback(func():
		panel_interact.visible = false
		mini_jeux.visible = true
		Input.mouse_mode =Input.MOUSE_MODE_VISIBLE
		mini_jeux.start_miniJeux(MiniJeuxName))
