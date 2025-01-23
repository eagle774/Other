extends Node2D
## GRID
## The description of the script, what it can do,
## and any further detail.
##
## Class to handle multiple entitys moving and interacting within a grid.

class_name Grid;

## Dictionary of Vector2 -> Tile to store the game board.
var tiles: Dictionary;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.



## Create a grid entity at a given position give its name.
func create_entity(entity_name: String) -> GridEntity:
	return null # Replace with function body.

## Moves an entity from where it is to a new target pos.
## 
func move_entity(entity: GridEntity, target_pos: Vector2) -> bool:
	if tiles[target_pos].has_entity():
		return false

	tiles[entity.pos].remove_entity()
	tiles[target_pos].add_entity(entity)
	return true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

# 
