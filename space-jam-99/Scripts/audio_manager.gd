extends Node

@export var _music: AudioStreamPlayer
@export var _sfx: AudioStreamPlayer
@export var _ui: AudioStreamPlayer

const BUS_MUSIC := "Music"
const BUS_SFX := "SFX"
const BUS_UI := "UI"

@export var _ui_button:Array[AudioStream]

@export var _sfx_vox_vitesse:Array[AudioStream]

@export var _sfx_vox_degat:Array[AudioStream]

@export var _sfx_saut:AudioStream

@export var _sfx_explostion:AudioStream

@export var _music_pole_nord:AudioStream
@export var _music_pole_ile:AudioStream
@export var _music_pole_sud:AudioStream
@export var _music_gameplay:AudioStream
@export var _music_miniGame:AudioStream
@export var _music_credits:AudioStream

func _ready() -> void:
	if _music:
		_music.bus = BUS_MUSIC
		_music.loop = true
	if _sfx:
		_sfx.bus = BUS_SFX
	if _ui:
		_ui.bus = BUS_UI
	print(get_tree().get_current_scene().get_name())
	_readyMusic(0.0)

func _readyMusic(f:float=1.0)->void:
	if(get_tree().get_current_scene().get_name()=="res://Scenes/MainScenes/definitiveScene/pole_ile.tscn"):
		play_music(_music_pole_ile, f, 1)
	elif(get_tree().get_current_scene().get_name()=="res://Scenes/MainScenes/definitiveScene/pole_nord.tscn"):
		play_music(_music_pole_nord, f, 1)
	elif(get_tree().get_current_scene().get_name()=="res://Scenes/MainScenes/definitiveScene/pole_sud.tscn"):
		play_music(_music_pole_sud, f, 1)
	elif(get_tree().get_current_scene().get_name()=="res://Scenes/MainScenes/definitiveScene/Road1.tscn"||get_tree().get_current_scene().get_name()=="res://Scenes/MainScenes/definitiveScene/Road2.tscn"||get_tree().get_current_scene().get_name()=="res://Scenes/MainScenes/definitiveScene/Road3.tscn"):
		play_music(_music_gameplay, f, 1)
	elif(get_tree().get_current_scene().get_name()=="res://Scenes/MainScenes/definitiveScene/SceneCreditsWithShip.tscn" || get_tree().get_current_scene().get_name()=="res://Scenes/MainScenes/definitiveScene/ScientifeetShip.tscn" ):
		play_music(_music_credits, f, 1)

func play_sfx(stream: AudioStream) -> void:
	if not _sfx:
		push_error("AudioStreamPlayer _sfx non assigné.")
		return
	_sfx.stream = stream
	_sfx.play()

func play_ui_sfx(stream: AudioStream) -> void:
	if not _ui:
		push_error("AudioStreamPlayer _ui non assigné.")
		return
	_ui.stream = stream
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
