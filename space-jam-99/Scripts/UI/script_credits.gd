extends Control

@export var _movingControls : Array[Control]
var hue : float = 0.0
@export var _position : Array[Vector2] = [Vector2(0,0), Vector2(0,0), Vector2(0,0), Vector2(0,0), Vector2(0,0)]
@export var fspeed:float=5.0

func _ready()->void:
	var z:int=0
	for i in _movingControls:
		_position[z] = i.position
		z+=1

func _process(delta: float) -> void:
	_on_timer_timeout(delta)


func _on_timer_timeout(f:float):
	hue += 0.7 * f
	if hue >= 1.0:
		hue = 0.0
	var angle: float = hue * TAU
	var r: float = (sin(angle)*0.5)+0.5
	var g:float = (sin(angle + TAU /3)*0.5)+0.5
	var b: float = (sin(angle + TAU *2/3)*0.5)+0.5
	var u: float = cos(angle)
	var v: float = sin(angle)
	
	_movingControls[0].scale = Vector2(1+r/20,1+r/20)
	_movingControls[0].position = _position[0] + Vector2(r,g)*fspeed
	_movingControls[1].scale = Vector2(1+g/20,1+g/20)
	_movingControls[1].position =  _position[1] + Vector2(g,b)*fspeed
	_movingControls[2].scale = Vector2(1+b/20,1+b/20)
	_movingControls[2].position =  _position[2] + Vector2(b,r)*fspeed
	_movingControls[3].scale = Vector2(1+u/20,1+u/20)
	_movingControls[3].position =  _position[3] + Vector2(u,v)*fspeed
	_movingControls[4].scale = Vector2(1+v/20,1+v/20)
	_movingControls[4].position =  _position[4] + Vector2(v,u)*fspeed
