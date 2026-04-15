extends TextureButton
var wakeuped:bool=false
var _wakeuped:bool=false
var hue:float=0.0
var timer:float=0.0

func wakeup()->void:
	_wakeuped = true
	timer=0.0
	$".".disabled=false
	$".".scale=Vector2(0,0)
	var tween = get_tree().create_tween()
	tween.tween_property($".", "scale", Vector2(1,1), 2).set_trans(Tween.TRANS_BOUNCE)

func sleep()->void:
	wakeuped = false
	$".".disabled=true
	$".".scale=Vector2(0,0)

func _process(delta: float) -> void:
	if(_wakeuped):
		timer+=delta
		if(timer>=2.0):
			wakeuped=true
			_wakeuped=false
			timer=0.0
	if(wakeuped):
		_on_timer_timeout(delta)

func _on_timer_timeout(f:float):
	hue += 0.7*f
	if hue >= 1.0:
		hue = 0.0
	var angle: float = hue * TAU
	var r: float = (sin(angle)*0.5)+0.5
	$".".scale = Vector2((1+r/10),1+r/10)
	$".".rotation = 0.1*cos(angle)
