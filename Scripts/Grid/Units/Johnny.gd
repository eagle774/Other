extends GridCharacter

class_name Johnny;


func _ready() -> void:
	super._ready()
	speed = 2


func _on_clickable_hitbox_clicked() -> void:
	print("Aww, you're cute.")
	InstanceHandler.active_grid.reset_tiles()
	var m: MovementMap = construct_move_map(4)
	for tile: Tile in m.get_reachable_tiles():
		tile.set_state(Tile.TileState.SELECTABLE)
