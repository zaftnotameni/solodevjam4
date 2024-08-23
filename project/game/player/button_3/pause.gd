class_name B3Pause extends Node2D

@onready var character : CharacterScene = owner
@onready var components : PlayerComponents = PlayerComponents.resolve(character)
@onready var input := components.resolve_input()

func _enter_tree() -> void:
	process_mode = PROCESS_MODE_ALWAYS

func pause_or_unpause_game():
	set_process_unhandled_input(false)
	get_tree().paused = not get_tree().paused
	print_verbose('game paused %s' % get_tree().paused)
	await get_tree().create_timer(0.3, true).timeout
	set_process_unhandled_input(true)

func _unhandled_input(event: InputEvent) -> void:
	if input.is_button_three_pressed(event):
		get_viewport().set_input_as_handled()
		
		await pause_or_unpause_game()

