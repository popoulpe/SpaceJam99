extends TextureRect

@export var movingBackgrounds : Array[TextureRect]
@export var movingClouds : Array[TextureRect]
@export var _colors : Array[Color]= [Color(1,1,1), Color(1,1,1), Color(1,1,1), Color(1,1,1)]
var hue : float = 0.0
var t : float = 0.0
@export var positionClouds : Array[Vector2] = [Vector2(0,0), Vector2(0,0), Vector2(0,0)]
@export var bTransitionning:bool=false

func _ready()->void:
	positionClouds[0]=movingClouds[0].position
	positionClouds[1]=movingClouds[1].position
	positionClouds[2]=movingClouds[2].position
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	_on_timer_timeout(delta)
	if(bTransitionning):
		transitioning(delta,$"../all_buttons".iLevel+1)

func _on_timer_timeout(f:float):
	hue += 0.7 * f
	if hue >= 1.0:
		hue = 0.0
	var angle: float = hue * TAU
	var r: float = (sin(angle)*0.5)+0.5
	var g:float = (sin(angle + TAU /3)*0.5)+0.5
	var b: float = (sin(angle + TAU *2/3)*0.5)+0.5
	
	movingBackgrounds[0].scale = Vector2(1.1+r/25,1.1+r/25)
	movingBackgrounds[0].position.y = r/2
	movingBackgrounds[1].scale = Vector2(1.1+g/25,1.1+g/25)
	movingBackgrounds[1].position.y = g/2
	
	movingClouds[0].scale = Vector2(1+r/20,1+r/20)
	movingClouds[0].position = positionClouds[0] + Vector2(r*2,g*2)
	movingClouds[1].scale = Vector2(1+g/20,1+g/20)
	movingClouds[1].position =  positionClouds[1] + Vector2(g*2,b*2)
	movingClouds[2].scale = Vector2(1+b/20,1+b/20)
	movingClouds[2].position =  positionClouds[2] + Vector2(b*2,r*2)

func transitioning(f:float, i:int):
	t+=f*0.1
	$".".modulate= $".".modulate.lerp(_colors[i],t)
	if($".".modulate==_colors[i]):
		bTransitionning=false
