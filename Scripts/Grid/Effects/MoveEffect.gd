extends BaseEffect
class_name MoveEffect

var new_pos: Vector2i
var target: GridEntity

## A move effect moves target itarget to pos inew_pos
func _init(itarget: GridEntity, inew_pos: Vector2i) -> void:
	target = itarget
	new_pos = inew_pos

func on_enacted() -> void:
	InstanceHandler.active_grid.move_entity(target, new_pos)
