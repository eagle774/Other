extends Node

class_name CharacterAction

var action_name: String = "Hi"
var character: GridCharacter

func _init(_character: GridCharacter) -> void:
	pass

func on_tile_selected(_owner: GridCharacter) -> void:
	pass

func on_enacted(_owner: GridCharacter) -> void:
	pass
