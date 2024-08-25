class_name SubmitsVictoryTime extends Node

func _ready() -> void:
	var victory_time := State.victory_time
	var player_name := Config.get_player_name()
	if victory_time < 10: return
	if not player_name or player_name.is_empty(): return

	var success := await Leaderboards.post_guest_score(SmartQuiver.default_leaderboard_id, victory_time, player_name)

	if not success: printerr('error submitting guest score')

func _enter_tree() -> void:
	process_mode = ProcessMode.PROCESS_MODE_INHERIT if Engine.is_editor_hint() else ProcessMode.PROCESS_MODE_ALWAYS
