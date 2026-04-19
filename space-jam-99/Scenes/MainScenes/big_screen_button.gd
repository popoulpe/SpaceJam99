extends TextureButton
var color_rect: ColorRect
var hue: float = 0.0
var hovering:bool = false;
@export var _sprites:Array[Texture];
@export var bIsBig:bool=false;
 
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hue = 0.0
func _on_mouse_entered() -> void:
	var tween = get_tree().create_tween()
	tween.set_parallel()
	tween.tween_property($".", "scale", Vector2(1.3,1), 0.25).set_trans(Tween.TRANS_BOUNCE)
	hovering = true

func _on_mouse_exited() -> void:
	var tween = get_tree().create_tween()
	tween.tween_property($".", "scale", Vector2(0.8,0.8), 0.35).set_trans(Tween.TRANS_ELASTIC)
	hovering = false

func _on_timer_timeout(f:float):
	if(hovering):
		hue += 0.7 * f 
	else:
		hue += 0.1*f
	
	if hue >= 1.0:
		hue = 0.0
	var angle: float = hue * TAU
	var r: float = (sin(angle)*0.5)+0.5
	var g:float = (sin(angle + TAU /3)*0.5)+0.5
	var b: float = (sin(angle + TAU *2/3)*0.5)+0.5
	$".".self_modulate = Color(r, g, b)
	
	if(hovering):
		$".".scale = Vector2((1+r/10),1+r/10)
	else:
		$".".scale = Vector2(1+r/25,1+r/25)


func _process(delta: float) -> void:
	_on_timer_timeout(delta)


func _on_pressed() -> void:
	bIsBig=!bIsBig
	if(bIsBig):
		$".".texture_normal = _sprites[0]
	else:
		$".".texture_normal = _sprites[1]
