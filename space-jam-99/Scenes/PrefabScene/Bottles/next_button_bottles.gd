extends TextureButton
var wakeuped:bool=false
var _wakeuped:bool=false
var hue:float=0.0
var timer:float=0.0
@export
var progressBar: TextureProgressBar
var bProgressingBar:bool=false
var progressTint : Color

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	progressTint = progressBar.tint_progress

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
		progressedBar(delta)

func progressedBar(f:float)->void:
	if(bProgressingBar):
		progressBar.value+=f
		if(progressBar.value>=$"..".iLevel+1):
			bProgressingBar=false
			progressBar.tint_progress =progressTint
			endProgressingBar()

func endProgressingBar()->void:
	var tween = get_tree().create_tween()
	tween.tween_property(progressBar, "scale", Vector2(1.2,1.2), 1.2).set_trans(Tween.TRANS_ELASTIC)
	tween.tween_property(progressBar, "scale", Vector2(1,1), 0.45).set_trans(Tween.TRANS_ELASTIC)

func _on_timer_timeout(f:float):
	hue += 0.7*f
	if hue >= 1.0:
		hue = 0.0
	var angle: float = hue * TAU
	var r: float = (sin(angle)*0.5)+0.5
	$".".scale = Vector2((1+r/10),1+r/10)
	$".".rotation = 0.1*cos(angle)
