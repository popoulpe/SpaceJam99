extends Control
class_name ui_hud_scientifeet

@onready var character_body_3d = $".."
@onready var panel_interact = $interaction
@onready var panel_scientifeet = $Dialogue
@onready var all_control = $"."
@onready var label_scientifeet = $Dialogue/Blabla/RichTextLabel

func show_interact_ui():
	all_control.visible = true

func hide_interact_ui():
	all_control.visible = false

func interact(text:String) -> void:
	var tween = get_tree().create_tween()
	tween.tween_property(panel_interact, "scale", Vector2(0.8,0.8), 0.25).set_trans(Tween.TRANS_ELASTIC)
	tween.tween_property(panel_interact, "scale", Vector2(1.05,1.05), 0.2).set_trans(Tween.TRANS_ELASTIC)
	tween.tween_property(panel_interact, "scale", Vector2(1,1), 0.1).set_trans(Tween.TRANS_ELASTIC)
	tween.tween_callback(func():
		panel_interact.visible = false
		panel_scientifeet.visible = true
		label_scientifeet.start_dialogue(text))
