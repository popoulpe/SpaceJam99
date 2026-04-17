extends Control
class_name ToDeleteHud

@onready var character_body_3d = $".."
@onready var temps = $Temps
@onready var vitesse = $Vitesse
@onready var interactPanel = $Control/Panel
@onready var panel_scientifeet = $"Control/panel du scientifeet"
@onready var control = $Control
@onready var label_scientifeet = $"Control/panel du scientifeet/Label"

# nb interaction est supprimable
#c'est juste du test pour montrer que ca marche
var nbInteractions :int=0 
var timeColor : Color

func _process(delta):
	vitesse.text = "speed: " + str(snapped(character_body_3d.velocity.length(), 0.01))
	if temps.has_theme_color_override("font_color"):
		temps.remove_theme_color_override("font_color")
	if timeColor != Color.WHITE:
		temps.add_theme_color_override("font_color", timeColor)
		timeColor = lerp(timeColor, Color.WHITE, 2 * delta)
	

func time_update(time:float, gotHit:bool):
	temps.text = str(snapped(time, 0.01))
	if gotHit:
		timeColor = Color.RED
		temps.add_theme_color_override("font_color", timeColor)

func show_interact_ui():
	control.visible = true

func hide_interact_ui():
	control.visible = false

func interact() -> void:
	interactPanel.visible = false
	panel_scientifeet.visible = true
	nbInteractions+=1
	label_scientifeet.text = "interagi " + str(nbInteractions) + " fois"
