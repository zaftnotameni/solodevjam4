class_name VentScene extends AnimatedSprite2D

@onready var area : Area2D = $Area2D

var character : CharacterScene

var vent_max_speed : float = 200.0
var vent_acceleration : float = 1000.0

func _physics_process(delta: float) -> void:
	if not character: return
	if character.velocity.y < -vent_max_speed: return
	character.velocity.y = move_toward(character.velocity.y, -vent_max_speed, delta * vent_acceleration)

func on_body_entered(body:Node2D):
	if body is CharacterScene: character = body
	if character: set_physics_process(true)
	if character: character.set_meta('vent', true)

func on_body_exited(body:Node2D):
	if body is CharacterScene: character = null
	if body is CharacterScene: body.set_meta('vent', false)
	if not character: set_physics_process(false)

func _ready() -> void:
	area.body_entered.connect(on_body_entered)
	area.body_exited.connect(on_body_exited)

