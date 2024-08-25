@tool
class_name SelfDrawingPath2D extends Path2D

func _draw() -> void:
	if not curve: return
	var points := curve.tessellate()
	for i in points.size():
		var a := points[i]
		var b := points[i + 1] if (i + 1) < points.size() else points[0]
		draw_line(a, b, Color('#580f8c'))

