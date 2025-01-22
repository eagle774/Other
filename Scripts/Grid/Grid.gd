extends Node2D
## GRID
## The description of the script, what it can do,
## and any further detail.
##
## Class to handle multiple entitys moving and interacting within a grid.

class_name Grid;


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

## Create a grid entity at a given position give its name.
func create_entity(entity_name: String) -> GridEntity:
	return null # Replace with function body.

## Create a grid entity at a given position give its name.
func move_entity(entity: GridEntity, target: Vector2) -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

# 
