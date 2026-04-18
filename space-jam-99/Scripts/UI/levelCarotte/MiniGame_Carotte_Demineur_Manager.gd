extends Control
@export var all_buttons:Array[TextureButton]
@export var levels_ : Dictionary
@export var _images : Array[Texture]
@export var _base_image : Texture
@export var _thisLevel_group_1 : Array[TextureButton]
@export var _thisLevel_group_2 : Array[TextureButton]
@export var _thisLevel_group_carotte : Array[TextureButton]
@export var iCaseRevealed : int =0
@export var iCaseBombe : int = 0
var iLevel = 0
@export var _progressBar : TextureProgressBar
var bProgressingBar:bool=false
var hue : float = 0.0
var progressTint : Color
var bSuccess:bool=false
var buttonRotating:bool=false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	progressTint = _progressBar.tint_progress
	awaken()

func awaken()->void:
	$Background.restart()
	bSuccess=false
	_thisLevel_group_1.clear()
	_thisLevel_group_2.clear()
	_thisLevel_group_carotte.clear()
	_progressBar.tint_progress =progressTint
	iCaseRevealed=0
	iCaseBombe=0
	iLevel = randi() % 5
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
			_thisLevel_group_carotte.append(i)
		z+=1
	_progressBar.max_value=64-iCaseBombe

func EndGame()->void:
	if(bSuccess):
		for i in _thisLevel_group_carotte:
			i.goodCarotteAwaken()
		var tween = get_tree().create_tween()
		tween.tween_property($TextureButton, "scale", Vector2(0,0), 1.6).set_trans(Tween.TRANS_BOUNCE)
		tween.tween_callback(func():endButton())
	else:
		endButton()

func endButton()->void:
	var tween = get_tree().create_tween()
	tween.tween_property($TextureButton, "scale", Vector2(1,1), 1.2).set_trans(Tween.TRANS_BOUNCE)
	buttonRotating=true
	$TextureButton.disabled=false
	$TextureButton.visible=true
	$TextureButton/TextureRect.visible=!bSuccess
	$TextureButton/TextureRect2.visible=bSuccess

func _on_texture_button_pressed() -> void:
	if(bSuccess):
		GlobalScript.asFinishedLevelTask = true
		GlobalScript.canMove = true
		visible = false
		print("YOUPI")
	else:
		var tween = get_tree().create_tween()
		tween.tween_property($TextureButton, "scale", Vector2(0.8,0.8), 0.25).set_trans(Tween.TRANS_ELASTIC)
		tween.tween_property($TextureButton, "scale", Vector2(1,1), 0.15).set_trans(Tween.TRANS_ELASTIC)
		tween.tween_callback(func():
			buttonRotating=false
			$TextureButton.disabled=true
			$TextureButton.visible=false
			$TextureButton.scale=Vector2(0,0)
			awaken()
		)

func groupAwaken(i:int)->void:
	if(i==1):
		for y in _thisLevel_group_1:
			if(y._thisText.texture!= _images[y._index]):
				y.awaken()
	else:
		for y in _thisLevel_group_2:
			if(y._thisText.texture!= _images[y._index]):
				y.awaken()

func _progressing()->void:
	iCaseRevealed+=1
	bProgressingBar=true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	hue += 0.7*delta
	if hue >= 1.0:
		hue = 0.0
	var angle: float = hue * TAU
	var r: float = (sin(angle)*0.5)+0.5
	var g:float = (sin(angle + TAU /3)*0.5)+0.5
	var b: float = (sin(angle + TAU *2/3)*0.5)+0.5
	if(bProgressingBar):
		_progressBar.tint_progress=Color(r, g, b)
		progressedBar(delta)
	elif(bSuccess):
		_progressBar.tint_progress=Color(r, g, b)
	if(buttonRotating):
		$TextureButton.rotation = 0.01*cos(angle)

func progressedBar(f:float)->void:
	if(bProgressingBar):
		_progressBar.value+=f*20
		if(_progressBar.value>=iCaseRevealed):
			bProgressingBar=false
			_progressBar.tint_progress =progressTint
			endProgressingBar()

func endProgressingBar()->void:
	var tween = get_tree().create_tween()
	tween.tween_property(_progressBar, "scale", Vector2(1.2,1.2), 1.2).set_trans(Tween.TRANS_BOUNCE)
	tween.tween_property(_progressBar, "scale", Vector2(1,1), 0.45).set_trans(Tween.TRANS_BOUNCE)
	tween.tween_callback(func():
		if(iCaseRevealed==64-iCaseBombe):
			bSuccess=true
			EndGame()
		)
