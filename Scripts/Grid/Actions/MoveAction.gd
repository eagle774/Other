extends CharacterAction

class_name MoveAction

var ownerMap: MovementMap

func _init(owner: GridCharacter, default_move_speed: int) -> void:
	super._init(owner)
	ownerMap = owner.construct_move_map(owner.move_dist)

func on_tile_selected(tile: Tile) -> EffectCluster:
	var e: EffectCluster = EffectCluster.new()
	var m: MoveEffect = MoveEffect.new(owner, tile.pos)
	e.add_effect(m)
	return e

func can_tile_be_selected(tile: Tile) -> bool:
	return ownerMap.can_end_on(tile)
