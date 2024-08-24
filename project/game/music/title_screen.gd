class_name TitleScreenBGM extends AudioStreamPlayer

const bgm : AudioStreamWAV = preload('res://assets/music/title_screen.wav')

func _init() -> void:
	stream = bgm
	bus = 'BGM'

func _ready() -> void:
	Audio.play_bgm(self)

func _exit_tree() -> void:
	stop()
