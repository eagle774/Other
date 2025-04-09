extends Node2D
## GRID
## The description of the script, what it can do,
## and any further detail.
##
## Class to handle multiple entitys moving and interacting within a grid.

class_name Grid;

#region Variable declarations

##
const tilesize: Vector2i = Vector2i(64,64)

## Vector2 to scale from grid units to global units.
var gridScale: Vector2 = tilesize*5/4

## Offset of the grid from the world origin, usually zero.
var offset: Vector2 = tilesize*3/4

## Number of columns in the grid / grid width
var gridWidth: int = 13

## Number of rows in the grid / grid height
var gridHeight: int = 13

## Dictionary of the game board.
var tiles: Dictionary[Vector2i, Tile] = {}

## the position of the character whose turn it is in character_turn_order
var character_turn_pos: int = 0
var character_turn_order: Array[GridCharacter]

## Array of entities
var entities: Array[GridEntity] = []

enum GameState {ANIMATING, CHARACTER_SELECTED, ACTION_SELECTED, ACTION_PREVIEW}

##
var game_state: GameState = GameState.CHARACTER_SELECTED

#endregion

func _ready() -> void:
	InstanceHandler.active_grid = self;
	init_tiles()
	create_entity("Characters/Johnny", Vector2i(1, 1))
	create_entity("Characters/Johnny", Vector2i(2, 1))
	create_entity("Characters/Johnny", Vector2i(2, 4))
	create_entity("Characters/Timmy", Vector2i(7, 5))
	create_entity("Characters/Sally", Vector2i(12, 0))
	#TODO: Add testing code for actions
	calc_turn_order()
	character_take_turn()

#region Tile managment functions


func init_tiles() -> void:
	for i in range(gridWidth):
		for j in range(gridHeight):
			create_tile("", Vector2i(i, j))

func create_tile(tile_name: String, pos: Vector2i) -> Tile:
	#var tile_scene: Resource = load("res://Prefabs/Tiles/"+tile_name+".tscn");
	# TODO: cache all tile_scenes on loading the map and store them in a dictionary
	var tile_scene: Resource = load("res://Prefabs/Tile.tscn")
	var tile: Tile = tile_scene.instantiate()
	tile.pos = pos
	add_child(tile)
	tiles[pos] = tile
	return tile

func reset_tiles() -> void:
	for tile: Tile in tiles.values():
		tile.set_state(Tile.TileState.DEFAULT)

#endregion


#region Entity managment functions




## Create a grid entity at a given position
func create_entity(entity_name: String, pos: Vector2i) -> GridEntity:
	var entity_scene: Resource = load("res://Prefabs/Entities/"+entity_name+".tscn")
	# TODO: cache all tile_scenes on loading the map and store them in a dictionary
	var entity: GridEntity = entity_scene.instantiate()
	print(entity)
	entity.pos = pos
	add_child(entity)
	tiles[pos].add_entity(entity)
	entities.append(entity)
	return entity



## Moves an entity from where it is to a new target pos.
func move_entity(entity: GridEntity, target_pos: Vector2i) -> bool:
	if tiles[target_pos].has_entity():
		return false
	tiles[entity.pos].remove_entity()
	tiles[target_pos].add_entity(entity)
	return true


## Find all entities satisfying a given condition
func find_all(condition: Callable) -> Array[GridEntity]:
	var result: Array[GridEntity] = []
	for entity in entities:
		if condition.call(entity):
			result.append(entity)
	return result

#endregion

#region Turn Order

func get_cur_character() -> GridCharacter:
	return character_turn_order[character_turn_pos]

# deliberately overridable
var turn_order_comp: Callable = func(c1: GridCharacter, c2: GridCharacter) -> int:
	if c1.speed < c2.speed:
		return true
	return false


func calc_turn_order() -> void:
	var is_char: Callable = func (entity: GridEntity) -> bool:
		return entity is GridCharacter
	var characters: Array[GridCharacter]
	characters.assign(find_all(is_char) as Array[GridCharacter])
	print(find_all(is_char) as Array[GridCharacter])
	characters.sort_custom(turn_order_comp)
	character_turn_order = characters


func character_take_turn() -> void:
	var cur: GridCharacter = get_cur_character()
	# Display UI for actions cur can take
	if true:
		game_state = GameState.ACTION_SELECTED
		InstanceHandler.active_grid.reset_tiles()
		# User selectes move
		cur.show_move()

	
#endregion

#region Utility functions


func calc_position(pos: Vector2i) -> Vector2i:
	return (scale(pos) as Vector2) + offset

func scale(pos: Vector2i) -> Vector2i:
	return (pos as Vector2) * gridScale

func is_in_grid(pos: Vector2i) -> bool:
	return pos.x >= 0 && pos.y >=0 && pos.x < gridWidth && pos.y < gridHeight

func get_tile(pos: Vector2i) -> Tile:
	if is_in_grid(pos):
		return tiles[pos]
	return null

func walking_distance(pos1: Vector2i, pos2: Vector2i) -> int:
	var dist_vector: Vector2i = abs(pos1-pos2)
	return dist_vector.x+dist_vector.y


#endregion

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

# 
