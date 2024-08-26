class_name TitleScreenBGM extends AudioStreamPlayer

const bgm : AudioStreamWAV = preload('res://assets/music/title_screen.wav')

var named := 'title'

func _enter_tree() -> void:
	stream = bgm
	bus = 'BGM'
	playback_type = AudioServer.PLAYBACK_TYPE_STREAM
	volume_db = 5
	set('parameters/looping', true)

func on_named_song_start_requested(named_song:String):
	if named_song == named:
		if not playing:
			Audio.play_bgm(self)
	else:
		if playing:
			stop()

func on_named_song_stop_requested(named_song:String):
	if named_song == named:
		if playing:
			stop()

func _ready() -> void:
	if Audio.first():
		Audio.first().sig_named_song_start_requested.connect(on_named_song_start_requested)
		Audio.first().sig_named_song_stop_requested.connect(on_named_song_stop_requested)

func _exit_tree() -> void:
	stop()
