extends Control
@export var all_buttons:Array[TextureButton]
@export var levels_ : Dictionary
@export var _images : Array[Texture]
@export var _base_image : Texture
@export var _thisLevel_group_1 : Array[TextureButton]
@export var _thisLevel_group_2 : Array[TextureButton]
@export var iCaseRevealed : int =0
@export var iCaseBombe : int = 0
var iLevel = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	awaken()

func awaken()->void:
	iCaseRevealed=0
	iCaseBombe=0
	for a in _thisLevel_group_1:
		a.empty()
	for b in _thisLevel_group_2:
		b.empty()
	iLevel = randi() % 5
	print(iLevel)
	var z = 0
	for i in all_buttons:
		i._thisText.texture = _base_image
		i._index = levels_[iLevel][z].x
		i._group = levels_[iLevel][z].y
		if(i._group==1):
			_thisLevel_group_1.append(i)
		elif(i._group==2):
			_thisLevel_group_2.append(i)
		if(i._index==5):
			iCaseBombe+=1
		z+=1

func Victory()->void:
	print("Victory!")

func groupAwaken(i:int)->void:
	if(i==1):
		for y in _thisLevel_group_1:
			if(y._thisText.texture!= _images[y._index]):
				y.awaken()
	else:
		for y in _thisLevel_group_2:
			if(y._thisText.texture!= _images[y._index]):
				y.awaken()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
