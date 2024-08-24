extends Label

@onready var color_rect = $ColorRect

func _ready() -> void:
	self.position = self.position.snapped(Vector2(16, 16))
	color_rect.custom_minimum_size = get_rect().size
	color_rect.set_deferred('size', get_rect().size)
	ControlUtil.control_set_full_rect.call_deferred(color_rect)
