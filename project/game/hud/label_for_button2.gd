class_name LabelForButton2 extends Label

var character : CharacterScene
var machine : StateMachine

@onready var b = %B
@onready var b_switch = %BSwitch
@onready var b_dash = %BDash

func on_player_ready():
	character = CharacterScene.first()
	if not character: return
	var components := character.resolve_components()
	if not components: return
	machine = components.resolve_machine_button2()
	if not machine: return
	machine.sig_state_did_transition.connect(on_button_changed)
	on_button_changed()

func on_button_changed(_curr:Node=null, _prev:Node=null):
	text = machine.current_state_name().replace('_', ' ').to_pascal_case()
	match machine.current_state_id():
		PlayerEnums.Button2.NOTHING:
			b.show()
			b_dash.hide()
			b_switch.hide()
		PlayerEnums.Button2.CHANGE_DIRECTION:
			b.hide()
			b_dash.hide()
			b_switch.show()
		PlayerEnums.Button2.DASH:
			b.hide()
			b_dash.show()
			b_switch.hide()

func _ready() -> void:
	State.first().sig_player_ready.connect(on_player_ready)
	on_player_ready()
