class_name DefaultInput extends Node2D

const GROUP := 'default_input'

static func tree() -> SceneTree: return Engine.get_main_loop()
static func first() -> DefaultInput: return tree().get_first_node_in_group(GROUP)
static func all() -> Array: return tree().get_nodes_in_group(GROUP)

func _unhandled_input(event: InputEvent) -> void:
	for ti:String in tracked_inputs:
		var n:String = ti.trim_prefix('last_')
		if DefaultInput['is_event_%s' % n].call(event):
			set(ti, 0)

func _physics_process(delta: float) -> void:
	do_process(delta)

func do_process(delta:float):
	for ti:String in tracked_inputs:
		var val := get(ti) as float
		if val >= 0 and val < max_seconds: set(ti, val + delta)

var max_seconds : float = 10.0
var tracked_inputs := [
	#'last_pause_pressed',
	#'last_unpause_pressed',
	#'last_menu_close_pressed',
	#'last_menu_accept_pressed',
	#'last_menu_back_pressed',
	#'last_player_up_pressed',
	#'last_player_down_pressed',
	#'last_player_left_pressed',
	#'last_player_right_pressed',
	#'last_player_jump_pressed',
	#'last_player_dash_pressed',
	#'last_player_roll_pressed',
	#'last_player_attack_pressed',
	#'last_player_interact_pressed',
	#'last_player_use_pressed',
	'last_player_button_one_pressed',
	'last_player_button_two_pressed',
	#'last_pause_released',
	#'last_unpause_released',
	#'last_menu_close_released',
	#'last_menu_accept_released',
	#'last_menu_back_released',
	#'last_player_up_released',
	#'last_player_down_released',
	#'last_player_left_released',
	#'last_player_right_released',
	#'last_player_jump_released',
	#'last_player_dash_released',
	#'last_player_roll_released',
	#'last_player_attack_released',
	#'last_player_interact_released',
	#'last_player_use_released',
	'last_player_button_one_released',
	'last_player_button_two_released',
]

var last_pause_pressed : float = -1
var last_unpause_pressed : float = -1
var last_menu_close_pressed : float = -1
var last_menu_accept_pressed : float = -1
var last_menu_back_pressed : float = -1
var last_player_up_pressed : float = -1
var last_player_down_pressed : float = -1
var last_player_left_pressed : float = -1
var last_player_right_pressed : float = -1
var last_player_jump_pressed : float = -1
var last_player_dash_pressed : float = -1
var last_player_roll_pressed : float = -1
var last_player_attack_pressed : float = -1
var last_player_interact_pressed : float = -1
var last_player_use_pressed : float = -1
var last_player_button_one_pressed : float = -1
var last_player_button_two_pressed : float = -1

var last_pause_released : float = -1
var last_unpause_released : float = -1
var last_menu_close_released : float = -1
var last_menu_accept_released : float = -1
var last_menu_back_released : float = -1
var last_player_up_released : float = -1
var last_player_down_released : float = -1
var last_player_left_released : float = -1
var last_player_right_released : float = -1
var last_player_jump_released : float = -1
var last_player_dash_released : float = -1
var last_player_roll_released : float = -1
var last_player_attack_released : float = -1
var last_player_interact_released : float = -1
var last_player_use_released : float = -1
var last_player_button_one_released : float = -1
var last_player_button_two_released : float = -1

static func is_event_pause_pressed(event:InputEvent) -> bool: return event.is_action_pressed('pause')
static func is_event_unpause_pressed(event:InputEvent) -> bool: return event.is_action_pressed('unpause')
static func is_event_menu_close_pressed(event:InputEvent) -> bool: return event.is_action_pressed('menu_close')
static func is_event_menu_accept_pressed(event:InputEvent) -> bool: return event.is_action_pressed('menu_accept')
static func is_event_menu_back_pressed(event:InputEvent) -> bool: return event.is_action_pressed('menu_back')
static func is_event_player_up_pressed(event:InputEvent) -> bool: return event.is_action_pressed('player_up')
static func is_event_player_down_pressed(event:InputEvent) -> bool: return event.is_action_pressed('player_down')
static func is_event_player_left_pressed(event:InputEvent) -> bool: return event.is_action_pressed('player_left')
static func is_event_player_right_pressed(event:InputEvent) -> bool: return event.is_action_pressed('player_right')
static func is_event_player_jump_pressed(event:InputEvent) -> bool: return event.is_action_pressed('player_jump')
static func is_event_player_dash_pressed(event:InputEvent) -> bool: return event.is_action_pressed('player_dash')
static func is_event_player_roll_pressed(event:InputEvent) -> bool: return event.is_action_pressed('player_roll')
static func is_event_player_attack_pressed(event:InputEvent) -> bool: return event.is_action_pressed('player_attack')
static func is_event_player_interact_pressed(event:InputEvent) -> bool: return event.is_action_pressed('player_interact')
static func is_event_player_use_pressed(event:InputEvent) -> bool: return event.is_action_pressed('player_use')
static func is_event_player_button_one_pressed(event:InputEvent) -> bool: return event.is_action_pressed('player_button_one')
static func is_event_player_button_two_pressed(event:InputEvent) -> bool: return event.is_action_pressed('player_button_two')

static func is_event_pause_released(event:InputEvent) -> bool: return event.is_action_released('pause')
static func is_event_unpause_released(event:InputEvent) -> bool: return event.is_action_released('unpause')
static func is_event_menu_close_released(event:InputEvent) -> bool: return event.is_action_released('menu_close')
static func is_event_menu_accept_released(event:InputEvent) -> bool: return event.is_action_released('menu_accept')
static func is_event_menu_back_released(event:InputEvent) -> bool: return event.is_action_released('menu_back')
static func is_event_player_up_released(event:InputEvent) -> bool: return event.is_action_released('player_up')
static func is_event_player_down_released(event:InputEvent) -> bool: return event.is_action_released('player_down')
static func is_event_player_left_released(event:InputEvent) -> bool: return event.is_action_released('player_left')
static func is_event_player_right_released(event:InputEvent) -> bool: return event.is_action_released('player_right')
static func is_event_player_jump_released(event:InputEvent) -> bool: return event.is_action_released('player_jump')
static func is_event_player_dash_released(event:InputEvent) -> bool: return event.is_action_released('player_dash')
static func is_event_player_roll_released(event:InputEvent) -> bool: return event.is_action_released('player_roll')
static func is_event_player_attack_released(event:InputEvent) -> bool: return event.is_action_released('player_attack')
static func is_event_player_interact_released(event:InputEvent) -> bool: return event.is_action_released('player_interact')
static func is_event_player_use_released(event:InputEvent) -> bool: return event.is_action_released('player_use')
static func is_event_player_button_one_released(event:InputEvent) -> bool: return event.is_action_released('player_button_one')
static func is_event_player_button_two_released(event:InputEvent) -> bool: return event.is_action_released('player_button_two')

static func is_input_pause_just_released() -> bool: return Input.is_action_just_released('pause')
static func is_input_unpause_just_released() -> bool: return Input.is_action_just_released('unpause')
static func is_input_menu_close_just_released() -> bool: return Input.is_action_just_released('menu_close')
static func is_input_menu_accept_just_released() -> bool: return Input.is_action_just_released('menu_accept')
static func is_input_menu_back_just_released() -> bool: return Input.is_action_just_released('menu_back')
static func is_input_player_up_just_released() -> bool: return Input.is_action_just_released('player_up')
static func is_input_player_down_just_released() -> bool: return Input.is_action_just_released('player_down')
static func is_input_player_left_just_released() -> bool: return Input.is_action_just_released('player_left')
static func is_input_player_right_just_released() -> bool: return Input.is_action_just_released('player_right')
static func is_input_player_jump_just_released() -> bool: return Input.is_action_just_released('player_jump')
static func is_input_player_dash_just_released() -> bool: return Input.is_action_just_released('player_dash')
static func is_input_player_roll_just_released() -> bool: return Input.is_action_just_released('player_roll')
static func is_input_player_attack_just_released() -> bool: return Input.is_action_just_released('player_attack')
static func is_input_player_interact_just_released() -> bool: return Input.is_action_just_released('player_interact')
static func is_input_player_use_just_released() -> bool: return Input.is_action_just_released('player_use')
static func is_input_player_button_one_just_released() -> bool: return Input.is_action_just_released('player_button_one')
static func is_input_player_button_two_just_released() -> bool: return Input.is_action_just_released('player_button_two')

static func is_input_pause_just_pressed() -> bool: return Input.is_action_just_pressed('pause')
static func is_input_unpause_just_pressed() -> bool: return Input.is_action_just_pressed('unpause')
static func is_input_menu_close_just_pressed() -> bool: return Input.is_action_just_pressed('menu_close')
static func is_input_menu_accept_just_pressed() -> bool: return Input.is_action_just_pressed('menu_accept')
static func is_input_menu_back_just_pressed() -> bool: return Input.is_action_just_pressed('menu_back')
static func is_input_player_up_just_pressed() -> bool: return Input.is_action_just_pressed('player_up')
static func is_input_player_down_just_pressed() -> bool: return Input.is_action_just_pressed('player_down')
static func is_input_player_left_just_pressed() -> bool: return Input.is_action_just_pressed('player_left')
static func is_input_player_right_just_pressed() -> bool: return Input.is_action_just_pressed('player_right')
static func is_input_player_jump_just_pressed() -> bool: return Input.is_action_just_pressed('player_jump')
static func is_input_player_dash_just_pressed() -> bool: return Input.is_action_just_pressed('player_dash')
static func is_input_player_roll_just_pressed() -> bool: return Input.is_action_just_pressed('player_roll')
static func is_input_player_attack_just_pressed() -> bool: return Input.is_action_just_pressed('player_attack')
static func is_input_player_interact_just_pressed() -> bool: return Input.is_action_just_pressed('player_interact')
static func is_input_player_use_just_pressed() -> bool: return Input.is_action_just_pressed('player_use')
static func is_input_player_button_one_just_pressed() -> bool: return Input.is_action_just_pressed('player_button_one')
static func is_input_player_button_two_just_pressed() -> bool: return Input.is_action_just_pressed('player_button_two')

static func is_input_pause_pressed() -> bool: return Input.is_action_pressed('pause')
static func is_input_unpause_pressed() -> bool: return Input.is_action_pressed('unpause')
static func is_input_menu_close_pressed() -> bool: return Input.is_action_pressed('menu_close')
static func is_input_menu_accept_pressed() -> bool: return Input.is_action_pressed('menu_accept')
static func is_input_menu_back_pressed() -> bool: return Input.is_action_pressed('menu_back')
static func is_input_player_up_pressed() -> bool: return Input.is_action_pressed('player_up')
static func is_input_player_down_pressed() -> bool: return Input.is_action_pressed('player_down')
static func is_input_player_left_pressed() -> bool: return Input.is_action_pressed('player_left')
static func is_input_player_right_pressed() -> bool: return Input.is_action_pressed('player_right')
static func is_input_player_jump_pressed() -> bool: return Input.is_action_pressed('player_jump')
static func is_input_player_dash_pressed() -> bool: return Input.is_action_pressed('player_dash')
static func is_input_player_roll_pressed() -> bool: return Input.is_action_pressed('player_roll')
static func is_input_player_attack_pressed() -> bool: return Input.is_action_pressed('player_attack')
static func is_input_player_interact_pressed() -> bool: return Input.is_action_pressed('player_interact')
static func is_input_player_use_pressed() -> bool: return Input.is_action_pressed('player_use')
static func is_input_player_button_one_pressed() -> bool: return Input.is_action_pressed('player_button_one')
static func is_input_player_button_two_pressed() -> bool: return Input.is_action_pressed('player_button_two')
