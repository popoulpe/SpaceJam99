extends TextureButton
@export var _thisText : TextureRect
@export var _index : int=0
@export var _group : int=0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_thisText=$TextureRect

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func awaken() -> void:
	$"../..".iCaseRevealed+=1
	_thisText.texture = $"../.."._images[_index]
	if($"../..".iCaseRevealed+$"../..".iCaseBombe==64):
		$"../..".Victory()

func _on_pressed() -> void:
	if(_thisText.texture != $"../.."._images[_index]):
		awaken()
		if(_group!=0):
			$"../..".groupAwaken(_group)
		if(_index==5):
			print("No")
