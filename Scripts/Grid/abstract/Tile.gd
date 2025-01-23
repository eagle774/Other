extends Node

class_name Tile

var _entity: GridEntity
var pos: Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

#region Entity Handling


## Add an entity to the tile if it is empty, otherwise errors.
func add_entity(entity: GridEntity) -> void:
	assert(_entity == null, 
			"Trying to put an entity in tile {tile} failed because that tile is already occupied with entity {entity}"
			.format({"tile": pos, "entity": _entity}))
			
	_entity = entity
	_entity.pos = pos


## Removes an entity from the tile if it has one, otherwise errors.
func remove_entity() -> void:
	assert(_entity == null, 
			"Trying to remove an entity in tile {tile} failed because that tile is empty."
			.format({"tile": pos}))
	_entity = null


## Returns true if the tile has an entity on it.
func has_entity() -> bool:
	return _entity == null

func get_entity() -> GridEntity:
	return _entity

#endregion

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
