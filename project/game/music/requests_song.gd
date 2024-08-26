class_name RequestsSong extends Node

@export_enum('none', 'level1', 'title') var song : String
@export var stops_on_exit : bool = false
@export var stops_on_ready : bool = false

func _ready() -> void:
	if Audio.first():
		if stops_on_ready:
			Audio.first().sig_named_song_stop_requested.emit(song)
		else:
			Audio.first().sig_named_song_start_requested.emit(song)

func _exit_tree() -> void:
	if Audio.first():
		if stops_on_exit:
			Audio.first().sig_named_song_stop_requested.emit(song)
