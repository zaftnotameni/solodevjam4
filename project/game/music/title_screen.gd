class_name TitleScreenBGM extends AudioStreamPlayer

const bgm : AudioStreamWAV = preload('res://assets/music/title_screen.wav')

func _enter_tree() -> void:
	stream = bgm
	bus = 'BGM'
	playback_type = AudioServer.PLAYBACK_TYPE_STREAM
	volume_db = 5
	set('parameters/looping', true)

func _ready() -> void:
	Audio.play_bgm(self)

func _exit_tree() -> void:
	stop()
