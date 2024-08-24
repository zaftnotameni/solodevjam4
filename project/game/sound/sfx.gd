class_name Sfx extends RefCounted

static func jump():
	Audio.play_sfx(Audio.first().get_node('SFX/Jump'))

static func land():
	Audio.play_sfx(Audio.first().get_node('SFX/Land'))

static func dash():
	Audio.play_sfx(Audio.first().get_node('SFX/Dash'))

static func flip():
	Audio.play_sfx(Audio.first().get_node('SFX/Flip'))
