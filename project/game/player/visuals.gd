class_name PlayerVisuals extends Node2D

func animate_asc():
	body_animated_sprite.play('asc')
	tween_start()
	t.tween_property(body_animated_sprite, 'scale', Vector2(1.1, 0.9), 0.1)
	t.tween_property(body_animated_sprite, 'scale', Vector2(0.9, 1.1), 0.1)
	t.tween_property(body_animated_sprite, 'scale', Vector2(1.0, 1.0), 0.1)

func animate_dsh():
	body_animated_sprite.play('dsh')

func animate_dsc():
	body_animated_sprite.play('dsc')

func animate_coy_or_gnd():
	body_animated_sprite.play('walk')

func animate_default():
	animate_coy_or_gnd()

func animate_coy():
	animate_coy_or_gnd()

func animate_gnd():
	animate_coy_or_gnd()
	tween_start()
	t.tween_property(body_animated_sprite, 'scale', Vector2(1.1, 0.9), 0.1)
	t.tween_property(body_animated_sprite, 'scale', Vector2(1.0, 1.0), 0.1)

func on_movement_state_machine_transition(_curr:Node=null,_prev:Node=null):
	cancel_animations()
	match machine_movement.current_state_id():
		PlayerEnums.Movement.ASC: animate_asc()
		PlayerEnums.Movement.DSC: animate_dsc()
		PlayerEnums.Movement.COY: animate_coy()
		PlayerEnums.Movement.GND: animate_gnd()
		PlayerEnums.Movement.DSH: animate_dsh()
		_: animate_default()

func _ready() -> void:
	machine_movement.sig_state_did_transition.connect(on_movement_state_machine_transition)

func _exit_tree() -> void:
	tween_kill()

func tween_kill():
	if t and t.is_running(): t.kill()
	t = null

func tween_start():
	t = create_tween()
	t.set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)

func cancel_animations():
	body_animated_sprite.rotation = 0
	body_animated_sprite.scale = Vector2(1, 1)
	body_animated_sprite.skew = 0
	tween_kill()

@onready var character : CharacterScene = owner
@onready var components : PlayerComponents = PlayerComponents.resolve(character)
@onready var machine_movement := components.resolve_machine_movement()
@onready var machine_direction := components.resolve_machine_direction()
@onready var stats := components.resolve_stats()
@onready var input := components.resolve_input()

@onready var body_animated_sprite : AnimatedSprite2D = %BodyAnimatedSprite

var t : Tween

