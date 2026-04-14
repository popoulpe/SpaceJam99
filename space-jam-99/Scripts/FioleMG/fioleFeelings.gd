extends TextureButton
class_name fioleFeelings

@export var check :Texture
@export var cross :Texture  

@onready var fillPrefab :=preload("uid://7byfg5oabxf6")
@onready var texture_rect = $TextureRect/TextureRect


@export var fioleBottomPos: Vector2= Vector2.ZERO
@export var fioleTopPos:Vector2= Vector2.ZERO
@export var maxQtt :int=2
@export var StarterLiquidColorOrder : Array[Color]= [Color.RED, Color.BLUE, Color.GREEN]


var nextPos :Vector2
var liquidPerFill : float 
var liquidsNodeList : Array[Node]
var colorOrderList : Array[Color]

var isFilled :bool = false
var actualQtt :int=0

func _ready():
	liquidPerFill = abs((fioleBottomPos.y - fioleTopPos.y)/maxQtt)
	nextPos = Vector2(fioleBottomPos.x, fioleBottomPos.y - liquidPerFill)
	
	for i in range(StarterLiquidColorOrder.size()):
		if !isFilled:
			fill(StarterLiquidColorOrder[i])

func fill(col: Color):
	if actualQtt ==0:
		nextPos = Vector2(fioleBottomPos.x, fioleBottomPos.y - liquidPerFill)
		
	var newLiquid = fillPrefab.instantiate()
	add_child(newLiquid)
	newLiquid.position = nextPos
	newLiquid.size = Vector2(newLiquid.size.x, liquidPerFill)
	newLiquid.modulate=col
	liquidsNodeList.append(newLiquid)
	
	colorOrderList.append(col)
	
	actualQtt+=1
	nextPos.y = (fioleBottomPos.y + fioleTopPos.y) - (liquidPerFill*(actualQtt+1))
	isFilled = actualQtt >= maxQtt

func empty(pos:Vector2) -> Color:
	actualQtt-=1
	var col = colorOrderList.pop_at(actualQtt)
	
	var temp = liquidsNodeList.pop_at(actualQtt)
	temp.queue_free()
	
	nextPos.y = (fioleBottomPos.y + fioleTopPos.y) - (liquidPerFill*(actualQtt+1))
	isFilled = actualQtt >= maxQtt
	
	return col

func isFinished() -> bool:
	if liquidsNodeList.size()==0:
		return setResult(true)
	if !isFilled:
		return setResult(false)
	var firstColor :Color = colorOrderList[0]
	for i in range(1, colorOrderList.size()):
		if colorOrderList[i] != firstColor:
			return setResult(false)
	return setResult(true)

func setResult(success:bool) ->bool:
	if success:
		texture_rect.texture = check
	else:
		texture_rect.texture = cross
	return success
