extends TextureRect

@export var movingBackgrounds : Array[TextureRect]
@export var _colors : Array[Color]= [Color(1,1,1), Color(1,1,1), Color(1,1,1), Color(1,1,1)]
var hue : float = 0.0
var t : float = 0.0
@export var bTransitionning:bool=false

func _process(delta: float) -> void:
	_on_timer_timeout(delta)
	if(bTransitionning):
		transitioning(delta,$"..".iLevel+1)

func _on_timer_timeout(f:float):
	hue += 0.7 * f
	if hue >= 1.0:
		hue = 0.0
	var angle: float = hue * TAU
	var r: float = (sin(angle)*0.5)+0.5
	var g:float = (sin(angle + TAU /3)*0.5)+0.5
	
	movingBackgrounds[0].scale = Vector2(1+r/35,1+r/35)
	movingBackgrounds[0].position.y = 5- r/4
	movingBackgrounds[1].scale = Vector2(1+g/35,1+g/35)
	movingBackgrounds[1].position.y = g/4

func transitioning(f:float, i:int):
	t+=f*0.1
	$".".modulate= $".".modulate.lerp(_colors[i],t)
	if($".".modulate==_colors[i]):
		bTransitionning=false
