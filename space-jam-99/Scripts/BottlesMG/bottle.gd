extends TextureButton
class_name Bottle


const MAX_LIQUID :int=4

@export var check :Texture
@export var cross :Texture 

@export var validationBox : TextureRect
@export var liquidsList:Array[ColorRect]
@export var colorPreset:Array[Color]

var actualLiquids:Array[Color]=[]
var actualQtt :int=0


func _ready():
	
	for i in range(colorPreset.size()):
		if !actualQtt >= MAX_LIQUID:
			fill(colorPreset[i])

func fill(col:Color) -> void:
	liquidsList[actualQtt].color = col
	liquidsList[actualQtt].visible = true
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


func setResult(success:bool) ->bool:
	if success:
		validationBox.texture = check
	else:
		validationBox.texture = cross
	return success
