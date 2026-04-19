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
	if _sfx:
		_sfx.bus = BUS_SFX
	if _ui:
		_ui.bus = BUS_UI
	print(get_tree().get_current_scene().get_name())
	_readyMusic(0.0)

func _readyMusic(f:float=1.0)->void:
	if(get_tree().get_current_scene().get_name()=="pole_ile"):
		play_music(_music_pole_ile, f, 1)
	elif(get_tree().get_current_scene().get_name()=="pole_nord"):
		play_music(_music_pole_nord, f, 1)
	elif(get_tree().get_current_scene().get_name()=="pole_sud"):
		play_music(_music_pole_sud, f, 1)
	elif(get_tree().get_current_scene().get_name()=="scene_MainMenu"||get_tree().get_current_scene().get_name()=="Road1"||get_tree().get_current_scene().get_name()=="Road2"||get_tree().get_current_scene().get_name()=="Road3"):
		play_music(_music_gameplay, f, 1)
	elif(get_tree().get_current_scene().get_name()=="SceneCreditsWithShip" || get_tree().get_current_scene().get_name()=="ScientifeetShip"):
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
	
	_music.stream = stream
	_music.play()
