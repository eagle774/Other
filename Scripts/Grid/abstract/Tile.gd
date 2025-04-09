extends Node2D

class_name Tile

var _entity: GridEntity = null
var pos: Vector2i
var move_cost: int = 1
enum TileState {DEFAULT, SELECTABLE}
var state: TileState = TileState.DEFAULT

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	position = InstanceHandler.active_grid.calc_position(pos)

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
	assert(_entity != null, 
			"Trying to remove an entity in tile {tile} failed because that tile is empty."
			.format({"tile": pos}))
	_entity = null


## Returns true if the tile has an entity on it.
func has_entity() -> bool:
	return _entity != null


## Returns the entity occupying the tile
func get_entity() -> GridEntity:
	return _entity

#endregion

func get_adjacent() -> Array[Tile]:
	var tiles: Array[Tile] = []
	var dirs: Array[Vector2i] = [Vector2i.DOWN, Vector2i.UP, Vector2i.RIGHT, Vector2i.LEFT]
	for dir in dirs:
		var target: Tile = InstanceHandler.active_grid.get_tile(pos+dir)
		if target:
			tiles.append(target)
	return tiles

func can_walk_through(_entity: GridEntity) -> bool:
	return !has_entity()

func can_end_on(_entity: GridEntity) -> bool:
	return true

func set_state(tile_state: TileState) -> void:
	state = tile_state
	set_color_by_state()

func set_color_by_state() -> void:
	match state:
		TileState.DEFAULT:
			change_color(Color(0, 1, 1))
		TileState.SELECTABLE:
			change_color(Color(1, 1, 1))

func change_color(color: Color) -> void:
	$Sprite2D.modulate = color


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_clickable_hitbox_clicked() -> void:
	if has_entity():
		get_entity()._on_clickable_hitbox_clicked()
