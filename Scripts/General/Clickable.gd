extends Area2D

signal clicked()

func _input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if (event is InputEventMouseButton && event.pressed):
		emit_signal("clicked")
