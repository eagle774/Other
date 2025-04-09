extends GridEntity

class_name GridCharacter

var speed: int = 4
var move_dist: int = 4

var cur_action: CharacterAction = null

#region navigation


func construct_move_map(max_dist: int) -> MovementMap:
	return MovementMap.new(max_dist, self)


func show_move() -> void:
	var m: MovementMap = construct_move_map(3)
	for tile: Tile in m.get_reachable_tiles():
		tile.set_state(Tile.TileState.SELECTABLE)


#endregion
