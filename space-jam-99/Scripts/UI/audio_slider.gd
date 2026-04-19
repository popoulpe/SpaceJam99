extends Control

@export var _textslider : TextureProgressBar
@export var _slider : HSlider
@export var _knob : TextureRect
@export var sliderType : String = "Music"

var bus_map = {
	"Music":1,
	"SFX": 2,
	"UI": 3
}

func _on_h_slider_value_changed(value: float) -> void:
	match sliderType:
		"Music", "SFX", "UI":
			var bus_index = bus_map[sliderType]
			AudioServer.set_bus_volume_db(bus_index, linear_to_db(value))
			_VisualChange(value)

func _ready() -> void:
	if(_slider==null):
		_slider=$HSlider
	if(_textslider==null):
		_textslider = $TextureProgressBar
	if(_knob==null):
		_knob = $KnobText
	_textslider.max_value = _slider.max_value
	_textslider.min_value = _slider.min_value
	_textslider.step = _slider.step
	_textslider.value = _slider.value
	_VisualChange(_textslider.value)

func _VisualChange(value: float) -> void:
	_textslider.value = value
	var range = _slider.max_value - _slider.min_value
	var ratio = (value - _slider.min_value) / range
	var slider_width = _slider.size.x
	var knob_x = ratio * slider_width - (_knob.size.x / 2)
	_knob.position.x = knob_x
	_knob.position.y = (_slider.size.y - _knob.size.y) / 2
