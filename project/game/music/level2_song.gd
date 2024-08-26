class_name Level2BGM extends AudioStreamPlayer

const bgm : AudioStreamWAV = preload('res://assets/music/level2.wav')

func _enter_tree() -> void:
	add_to_group(GROUP)
	stream = bgm
	bus = 'BGM'
	playback_type = AudioServer.PLAYBACK_TYPE_STREAM
	volume_db = -5
	set('parameters/looping', true)

var named := 'level2'

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

const GROUP := 'level2_bgm'

static func tree() -> SceneTree: return Engine.get_main_loop()
static func first() -> LevelBGM: return tree().get_first_node_in_group(GROUP)
static func all() -> Array: return tree().get_nodes_in_group(GROUP)
