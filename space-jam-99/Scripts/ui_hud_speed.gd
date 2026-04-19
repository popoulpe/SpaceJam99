extends Control
class_name ui_hud_speed

@onready var character_body_3d = $".."
@onready var temps = $Temps_/temps_label
@onready var vitesse_big = $Vitesse_/big_numbers
@onready var vitesse_little = $Vitesse_/little_numbers
@onready var vitess_progressBar  = $Vitesse_/TextureProgressBar
@onready var timeColor_wanted : Color
var fVitesseDeFou: float = 0.0
var vectorVitesseText:Vector2

# nb interaction est supprimable
#c'est juste du test pour montrer que ca marche
var nbInteractions :int=0 
var timeColor : Color

func _ready()->void:
	vectorVitesseText=vitesse_big.position

func _process(delta):
	vitesse_big.text = str(snapped(character_body_3d.velocity.length(), 1))
	vitesse_little.text = str(snapped(character_body_3d.velocity.length()*100, 1))
	vitess_progressBar.value = snapped(character_body_3d.velocity.length(), 0.1)
	#if temps.has_theme_color_override("font_color"):
		#temps.remove_theme_color_override("font_color")
	if timeColor != timeColor_wanted:
		temps.add_theme_color_override("font_color", timeColor)
		timeColor = lerp(timeColor, timeColor_wanted, 2 * delta)
	
	fVitesseDeFou += snapped(character_body_3d.velocity.length(), 1) * delta
	if fVitesseDeFou >= 1.0:
		fVitesseDeFou = 0.0
	
	var angle: float = fVitesseDeFou * TAU
	var r: float = sin(angle)
	var g:float = cos(angle)
	vitesse_big.position = Vector2(vectorVitesseText.x+r,vectorVitesseText.y+g)

func time_update(time:float, gotHit:bool):
	var snapped_time = snapped(time, 0.01)
	var seconds = int(snapped_time)
	var milliseconds = int((snapped_time - seconds) * 100)
	if (milliseconds < 0):
		milliseconds = 0
	temps.text = "%02d : %02d" % [seconds, milliseconds]
	if gotHit:
		timeColor = Color.RED
		temps.add_theme_color_override("font_color", timeColor)
