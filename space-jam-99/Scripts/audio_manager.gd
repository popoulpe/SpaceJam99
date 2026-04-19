extends Node

@export var _music: AudioStreamPlayer
@export var _sfx: AudioStreamPlayer
@export var _ui: AudioStreamPlayer

const BUS_MUSIC := "Music"
const BUS_SFX := "SFX"
const BUS_UI := "UI"

@export var _ui_button:Array[AudioStream]

@export var _all_musics:Array[AudioStream]

func _ready() -> void:
	if _music:
		_music.bus = BUS_MUSIC
		_music.loop = true
	if _sfx:
		_sfx.bus = BUS_SFX
	if _ui:
		_ui.bus = BUS_UI

func play_sfx(stream: AudioStream, pitch: float = 1.0, volume_db: float = 0.0) -> void:
	if not _sfx:
		push_error("AudioStreamPlayer _sfx non assigné.")
		return
	_sfx.stream = stream
	_sfx.pitch_scale = pitch
	_sfx.volume_db = volume_db
	_sfx.play()

func play_ui_sfx(stream: AudioStream, volume_db: float = 0.0) -> void:
	if not _ui:
		push_error("AudioStreamPlayer _ui non assigné.")
		return
	_ui.stream = stream
	_ui.volume_db = volume_db
	_ui.play()

func play_music(stream: AudioStream, fade_out_time: float = 0.0, fade_in_time: float = 0.0) -> void:
	if not _music:
		push_error("AudioStreamPlayer _music non assigné.")
		return
	
	if _music.playing and _music.stream != stream:
		if fade_out_time > 0:
			_fade_out_music(fade_out_time)
			await get_tree().create_timer(fade_out_time).timeout
	_music.stream = stream
	_music.volume_db = linear_to_db(0.0)
	_music.play()
	if fade_in_time > 0:
		_fade_in_music(fade_in_time)
	else:
		_music.volume_db = linear_to_db(1.0)

func _fade_out_music(duration: float) -> void:
	var timer := get_tree().create_timer(duration)
	while timer.time_left > 0:
		var progress := timer.time_left / duration
		var vol_db := linear_to_db(progress)
		_music.volume_db = vol_db
		await get_tree().process_frame
	_music.volume_db = -80.0
	_music.stop()

func _fade_in_music(duration: float) -> void:
	var timer := get_tree().create_timer(duration)
	while timer.time_left > 0:
		var progress := 1.0 - (timer.time_left / duration)
		var vol_db := linear_to_db(progress)
		_music.volume_db = vol_db
		await get_tree().process_frame
	_music.volume_db = linear_to_db(1.0)
