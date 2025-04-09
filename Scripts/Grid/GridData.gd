extends Node

const gridScale = Vector2(64, 64)
#var offset = Vector2(ProjectSettings.get_setting("display/window/size/viewport_width"),ProjectSettings.get_setting("display/window/size/viewport_height"))/2
var offset: Vector2 = Vector2(32, 32)


var gridSize: int = 13

func calc_position(position: Vector2i) -> Vector2:
	return scale(position) + offset

func scale(position: Vector2) -> Vector2:
	return position * gridScale

func is_in_grid(pos: Vector2i) -> bool:
	return pos.x >= 0 && pos.y >=0 && pos.x < gridSize && pos.y < gridSize
