extends TextureButton
@export var _thisText : TextureRect
@export var _index : int=0
@export var _group : int=0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_thisText=$TextureRect

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func awaken() -> void:
	$"../.."._progressing()
	_thisText.texture = $"../.."._images[_index]
	var tween = get_tree().create_tween()
	tween.tween_property($".", "scale", Vector2(1.2,1.2), 0.3).set_trans(Tween.TRANS_BOUNCE)
	tween.tween_property($".", "scale", Vector2(1,1), 0.4).set_trans(Tween.TRANS_BOUNCE)

func goodCarotteAwaken()->void:
	_thisText.texture = $"../.."._images[6]
	var tween = get_tree().create_tween()
	tween.tween_property($".", "scale", Vector2(1.4,1.4), 1.2).set_trans(Tween.TRANS_ELASTIC)
	tween.tween_property($".", "scale", Vector2(1,1), 0.4).set_trans(Tween.TRANS_ELASTIC)

func _on_pressed() -> void:
	if(_thisText.texture != $"../.."._images[_index]):
		awaken()
		var tween = get_tree().create_tween()
		tween.tween_property($".", "scale", Vector2(0.7,0.7), 0.2).set_trans(Tween.TRANS_BOUNCE)
		tween.tween_property($".", "scale", Vector2(1.2,1.2), 0.1).set_trans(Tween.TRANS_BOUNCE)
		if(_group!=0):
			$"../..".groupAwaken(_group)
		if(_index==5):
			awakenPourrie()

func awakenPourrie()->void:
	_thisText.texture = $"../.."._images[6]
	
	var tween = get_tree().create_tween()
	tween.tween_property($".", "scale", Vector2(0.8, 0.8), 0.2).set_trans(Tween.TRANS_ELASTIC)
	tween.tween_property($".", "scale", Vector2(1.4, 1.4), 1.2).set_trans(Tween.TRANS_ELASTIC)
	tween.tween_callback(func():_thisText.texture = $"../.."._images[_index])
	tween.parallel().tween_property($".", "rotation", -1, 0.4).set_trans(Tween.TRANS_ELASTIC)
	tween.tween_property($".", "rotation", 1, 0.4).set_trans(Tween.TRANS_ELASTIC)
	tween.tween_property($".", "rotation",0 , 0.4).set_trans(Tween.TRANS_ELASTIC)
	tween.tween_property($".", "scale", Vector2(1, 1), 0.4).set_trans(Tween.TRANS_ELASTIC)
	tween.tween_callback(func():$"../..".EndGame())


func _on_mouse_entered() -> void:
	if(_thisText.texture != $"../.."._images[_index]):
		var tween = get_tree().create_tween()
		tween.tween_property($".", "scale", Vector2(0.95,0.95), 0.2).set_trans(Tween.TRANS_BOUNCE)
		tween.tween_property($".", "scale", Vector2(1.2,1.2), 0.1).set_trans(Tween.TRANS_BOUNCE)



func _on_mouse_exited() -> void:
	if(_thisText.texture != $"../.."._images[_index]):
		var tween = get_tree().create_tween()
		tween.tween_property($".", "scale", Vector2(0.8,0.8), 0.2).set_trans(Tween.TRANS_BOUNCE)
		tween.tween_property($".", "scale", Vector2(1,1), 0.1).set_trans(Tween.TRANS_BOUNCE)
