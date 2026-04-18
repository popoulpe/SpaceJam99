extends Control
class_name ui_hud_speed

@onready var character_body_3d = $".."
@onready var temps = $Temps_/temps_label
@onready var vitesse_big = $Vitesse_/big_numbers
@onready var vitesse_little = $Vitesse_/little_numbers
@onready var vitess_progressBar  = $Vitesse_/TextureProgressBar
@onready var timeColor_wanted : Color
var fVitesseDeFou: float = 0.0
var vectorVitesseTexture:Vector2

# nb interaction est supprimable
#c'est juste du test pour montrer que ca marche
var nbInteractions :int=0 
var timeColor : Color

func _ready()->void:
	vectorVitesseTexture=vitess_progressBar.position

func _process(delta):
	vitesse_big.text = str(snapped(character_body_3d.velocity.length(), 1))
	vitesse_little.text = str(snapped(character_body_3d.velocity.length()*1000, 0.0001))
	vitess_progressBar.value = snapped(character_body_3d.velocity.length(), 0.1)
	#if temps.has_theme_color_override("font_color"):
		#temps.remove_theme_color_override("font_color")
	if timeColor != timeColor_wanted:
		temps.add_theme_color_override("font_color", timeColor)
		timeColor = lerp(timeColor, timeColor_wanted, 2 * delta)
	
	fVitesseDeFou += 0.7 * delta
	if fVitesseDeFou >= 1.0:
		fVitesseDeFou = 0.0
	
	var angle: float = fVitesseDeFou * TAU
	var r: float = (sin(angle)*0.5)+0.5 * snapped(character_body_3d.velocity.length(), 1)*10
	var g:float = (sin(angle + TAU /3)*0.5)+0.5 * snapped(character_body_3d.velocity.length(), 1)*10
	vitess_progressBar.position = Vector2(vectorVitesseTexture.x+r,vectorVitesseTexture.y+g)

func time_update(time:float, gotHit:bool):
	temps.text = str(snapped(time, 0.01))
	if gotHit:
		timeColor = Color.RED
		temps.add_theme_color_override("font_color", timeColor)
