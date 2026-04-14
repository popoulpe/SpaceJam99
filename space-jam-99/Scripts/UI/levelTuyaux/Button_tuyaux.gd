extends TextureButton

@export
var tuyauxManager : Control

@export
var hue: float = 0.0
@export
var index: float
@export
var iSprite: int
@export
var fRotation: float
@export
var bisGood: bool=false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(bisGood):
		_on_timer_timeout(delta)
	else:
		$".".self_modulate = Color(1, 1, 1)

func _on_timer_timeout(f:float):
	if(iSprite!=3):
		hue += 0.7*f
		if hue >= 1.0:
			hue = 0.0
		var angle: float = hue * TAU
		var r: float = (sin(angle)*0.5)+0.5
		var g:float = (sin(angle + TAU /3)*0.5)+0.5
		var b: float = (sin(angle + TAU *2/3)*0.5)+0.5
		$".".self_modulate = Color(r, g, b)

func _on_pressed() -> void:
	if(iSprite==1):
		if(fRotation>=1):
			fRotation=0
			$".".rotation_degrees = 0
		else:
			fRotation=1
			$".".rotation_degrees = 90
	else:
		if(fRotation<3):
			fRotation+=1
			$".".rotation_degrees += 90
		else:
			fRotation=0
			$".".rotation_degrees = 0
	var tween = get_tree().create_tween()
	tween.tween_property($".", "scale", Vector2(0.9,0.9), 0.15).set_trans(Tween.TRANS_BOUNCE)
	tween.tween_property($".", "scale", Vector2(1.1,1.1), 0.2).set_trans(Tween.TRANS_BOUNCE)
	tween.tween_property($".", "scale", Vector2(1,1), 0.1).set_trans(Tween.TRANS_BOUNCE)
	
	tuyauxManager.i_LevelPipes[tuyauxManager.iLevel][index].y = fRotation
	tuyauxManager.CheckLevelCompletion()
