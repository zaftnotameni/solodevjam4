class_name LabelForButton2 extends Label

var character : CharacterScene
var machine : StateMachine

func on_player_ready():
	character = CharacterScene.first()
	if not character: return
	machine = character.resolve_components().resolve_machine_button2()
	if not machine: return
	machine.sig_state_did_transition.connect(on_button_changed)
	on_button_changed()

func on_button_changed(_curr:Node=null, _prev:Node=null):
	text = machine.current_state_name()

func _ready() -> void:
	State.first().sig_player_ready.connect(on_player_ready)
	on_player_ready()
