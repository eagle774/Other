extends Resource

class_name CharacterAction

var action_name: String = "Hi"
var owner: GridCharacter
var description: String = "Bye"

func _init(iowner: GridCharacter) -> void:
	owner = iowner

## Create an effect cluster for when the action is enacted on a specific tile
func on_tile_selected(tile: Tile) -> EffectCluster:
	return null

## Returns true if the given tile can be selected as a target for the action
func can_tile_be_selected(tile: Tile) -> bool:
	return true
