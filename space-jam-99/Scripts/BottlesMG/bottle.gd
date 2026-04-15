extends TextureButton
class_name Bottle


const MAX_LIQUID :int=4

@export var actualLiquid : TextureRect
@export var liquidsList_:Array[ColorRect]
@export var liquidsList:Array[TextureRect]
@export var colorPreset:Array[Color]

var actualLiquids:Array[Color]=[]
var actualQtt :int=0

@export
var hue: float = 0.0
@export
var isSelected : bool = false
var _success:bool = false

func _ready():
	for i in range(colorPreset.size()):
		if !actualQtt >= MAX_LIQUID:
			fill(colorPreset[i])

func fill(col:Color) -> void:
	liquidsList[actualQtt].self_modulate = col
	liquidsList[actualQtt].visible = true
	actualLiquid = liquidsList[actualQtt]
	actualLiquid.scale = Vector2(1.3,1.3)
	var tween = get_tree().create_tween()
	tween.tween_property(actualLiquid, "scale", Vector2(1,1), 0.25).set_trans(Tween.TRANS_BOUNCE)
	actualLiquids.append(col)
	actualQtt+=1

func empty() -> Color:
	actualQtt-=1
	liquidsList[actualQtt].visible = false
	return actualLiquids.pop_at(actualQtt)

func isFinished() -> bool:
	if actualLiquids.size()==0:
		return setResult(true)
	if !actualQtt >= MAX_LIQUID:
		return setResult(false)
	var firstColor :Color = actualLiquids[0]
	for i in range(1, actualLiquids.size()):
		if actualLiquids[i] != firstColor:
			return setResult(false)
	return setResult(true)

func notSelected()->void:
	print("oh")
	isSelected = false
	actualLiquid.scale = Vector2(1,1)
	actualLiquid.rotation = 0

func _process(delta: float) -> void:
	if(isSelected):
		selected(delta)
	elif(_success):
		successfull(delta)
	if(!_success):
		$BottleInterior.self_modulate= Color(1, 1, 1)
		$".".scale = Vector2(1,1)
		$".".rotation = 0

func selection():
	actualLiquid = liquidsList[actualQtt-1]
	isSelected=true
	
func successfull(f:float):
	hue += 0.7*f
	if hue >= 1.0:
		hue = 0.0
	var angle: float = hue * TAU
	var r: float = (sin(angle)*0.5)+0.5
	var g:float = (sin(angle + TAU /3)*0.5)+0.5
	var b: float = (sin(angle + TAU *2/3)*0.5)+0.5
	for i in liquidsList:
		i.self_modulate = Color(r, g, b)
	$BottleInterior.self_modulate= Color(r, g, b)
	$".".scale = Vector2((1+r/10),1+r/10)
	$".".rotation = 0.1*cos(angle)

func selected(f:float):
	hue += 0.8 * f
	if hue >= 1.0:
		hue = 0.0
	var angle: float = hue * TAU
	var r: float = (sin(angle)*0.5)+0.5
	actualLiquid.scale = Vector2((1+r/4),1+r/4)
	actualLiquid.rotation = 0.1*cos(angle)
	if (_success):
		for i in liquidsList:
			i.self_modulate = actualLiquids[actualQtt-1]
	else:
		actualLiquid.self_modulate = actualLiquids[actualQtt-1]

func setResult(success:bool) ->bool:
	if success:
		_success=true
	else:
		_success=false
	return success
