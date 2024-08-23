class_name PlayerStateMachine extends Node2D

@onready var components : PlayerComponents = PlayerComponents.resolve(owner)
@onready var machine_movement = components.resolve_machine_movement()
@onready var machine_direction = components.resolve_machine_direction()
@onready var machine_button0 = components.resolve_machine_button0()
@onready var machine_button1 = components.resolve_machine_button1()
@onready var machine_button2 = components.resolve_machine_button2()
@onready var machine_button3 = components.resolve_machine_button3()

func _ready() -> void:
	machine_movement.setup(PlayerEnums.Movement)
	machine_direction.setup(PlayerEnums.Direction)
	machine_button0.setup(PlayerEnums.Button0)
	machine_button1.setup(PlayerEnums.Button1)
	machine_button2.setup(PlayerEnums.Button2)
	machine_button3.setup(PlayerEnums.Button3)

	machine_movement.start(PlayerEnums.Movement.INITIAL)
	machine_direction.start(PlayerEnums.Direction.RIGHT)
	machine_button0.start(PlayerEnums.Button0.AUTO_MOVE)
	machine_button1.start(PlayerEnums.Button1.JUMP)
	machine_button2.start(PlayerEnums.Button2.CHANGE_DIRECTION)
	machine_button3.start(PlayerEnums.Button3.NOTHING)

	machine_movement.sig_state_will_transition.connect(state_will_change)
	machine_direction.sig_state_will_transition.connect(state_will_change)
	machine_button0.sig_state_will_transition.connect(state_will_change)
	machine_button1.sig_state_will_transition.connect(state_will_change)
	machine_button2.sig_state_will_transition.connect(state_will_change)
	machine_button3.sig_state_will_transition.connect(state_will_change)

func state_will_change(next:Node, curr:Node, prev:Node):
	printt(prev.name, curr.name, next.name)
