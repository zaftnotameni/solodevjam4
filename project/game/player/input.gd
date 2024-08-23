class_name PlayerInput extends Node2D

@onready var components : PlayerComponents = PlayerComponents.resolve(owner)
@onready var machine_movement = components.resolve_machine_movement()
@onready var machine_direction = components.resolve_machine_direction()
@onready var machine_button0 = components.resolve_machine_button0()
@onready var machine_button1 = components.resolve_machine_button1()
@onready var machine_button2 = components.resolve_machine_button2()
@onready var machine_button3 = components.resolve_machine_button3()

func is_jump_requested() -> bool:
	if DefaultInput.is_input_player_button_two_pressed(): return false
	if machine_button1.current_state_id() != PlayerEnums.Button1.JUMP: return false
	return DefaultInput.is_input_player_button_one_just_pressed()

func is_dash_requested() -> bool:
	if DefaultInput.is_input_player_button_one_pressed(): return false
	if machine_button2.current_state_id() != PlayerEnums.Button2.DASH: return false
	return DefaultInput.is_input_player_button_two_just_pressed()

func is_jump_cancelled() -> bool:
	return DefaultInput.is_input_player_button_one_just_released()

func is_dash_cancelled() -> bool:
	return DefaultInput.is_input_player_button_two_just_released()

func is_start_game_requested() -> bool:
	if machine_button3.current_state_id() != PlayerEnums.Button3.START_GAME: return false
	return DefaultInput.is_input_player_button_three_just_pressed()

func is_options_menu_game_requested() -> bool:
	if machine_button3.current_state_id() != PlayerEnums.Button3.OPTIONS_MENU: return false
	return DefaultInput.is_input_player_button_three_just_pressed()
