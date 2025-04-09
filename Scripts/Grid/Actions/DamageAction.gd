extends CharacterAction

class_name DamageAction

var damage: int

func _init(owner: GridCharacter, default_damage: int) -> void:
	super._init(owner)
	damage = default_damage

func edit_damage(new_damage: int) -> void:
	damage = new_damage

func on_tile_selected(tile: Tile) -> EffectCluster:
	var e: EffectCluster = EffectCluster.new()
	var m: DamageEffect = DamageEffect.new(tile.get_entity(), damage)
	e.add_effect(m)
	return e

func can_tile_be_selected(tile: Tile) -> bool:
	if tile.get_entity() == owner:
		return false
	return tile.has_entity()
