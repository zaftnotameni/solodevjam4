extends Node

@export var bus := Audio.AudioBus.SFX

func on_value_changed(new_value:float):
	Audio.set_volume_linear_0_100(bus, new_value, slider, value)
	Audio.play_volume_tick_sound(bus)

func _ready() -> void:
	Audio.get_volume_linear_0_100(bus, slider, value)
	slider.value_changed.connect(on_value_changed)

@onready var value := %Value
@onready var slider := %Slider
