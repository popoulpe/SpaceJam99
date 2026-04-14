extends Control
@export
var all_buttons: Array[TextureButton]
@export 
var i_LevelPipes: Dictionary
@export 
var i_RightLevelPipes: Dictionary
@export
var spritePipes: Array[Texture2D]

var f: float = 0.0

var buttonRotating:bool=false
var hue: float = 0.0

var iLevel:int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$"../TextureButton".scale = Vector2(0,0)
	$"../TextureButton".disabled=true
	$"../TextureButton".visible=false
	placementLevel(0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	hue += 0.7*delta
	if hue >= 1.0:
		hue = 0.0
	if(buttonRotating):
		f += 0.7 * delta
		if f >= 1.0:
			f = 0.0
		var angle: float = f * TAU
		$"../TextureButton".rotation = 0.1*cos(angle)
		var angle2: float = hue * TAU
		var r: float = (sin(angle2)*0.5)+0.5
		var g:float = (sin(angle2 + TAU /3)*0.5)+0.5
		var b: float = (sin(angle2 + TAU *2/3)*0.5)+0.5
		$"../EndTuyau".self_modulate = Color(r, g, b)

func endLevel()->void:
	var tween = get_tree().create_tween()
	tween.tween_property($"../TextureButton", "scale", Vector2(1,1), 1.2).set_trans(Tween.TRANS_ELASTIC)
	buttonRotating=true
	$"../TextureButton".disabled=false
	$"../TextureButton".visible=true

func newLevel()->void:
	for i in all_buttons:
		i.bisGood = false
	$"../TextureButton".scale = Vector2(0,0)
	$"../EndTuyau".self_modulate = Color(1, 1, 1)
	buttonRotating=false
	$"../TextureButton".disabled=true
	$"../TextureButton".visible=false
	iLevel+=1
	placementLevel(iLevel)

func placementLevel(y:int)->void:
	var z:float = 0
	for i in all_buttons:
		i.texture_normal = spritePipes[i_LevelPipes[y][z].x]
		i.rotation_degrees = 90 * i_LevelPipes[y][z].y
		i.index = z
		i.iSprite = i_LevelPipes[y][z].x
		i.fRotation = i_LevelPipes[y][z].y
		z+=1
	
	$"../EndTuyau".self_modulate = Color(1, 1, 1)
	$"../TextureButton".scale = Vector2(0,0)
	buttonRotating=false
	$"../TextureButton".disabled=true
	$"../TextureButton".visible=false
	
func CheckLevelCompletion()->void:
	var z:float = 0
	var right:bool=true
	for j in i_RightLevelPipes[iLevel]:
		if(j.x!=all_buttons[z].fRotation && j.y!=all_buttons[z].fRotation && j.x!=-1):
			right=false
			all_buttons[z].bisGood=false
		else:
			if(j.x!=-1):
				all_buttons[z].bisGood=true
				all_buttons[z].hue=hue
		z+=1
	if(right):
		endLevel()

func _on_texture_button_pressed() -> void:
	if(buttonRotating):
		newLevel()
