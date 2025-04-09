extends Resource
class_name MovementMap
## Creates a map of walkable tiles around a character 

var grid: GameBoard = InstanceHandler.active_grid
# A Vector2i -> int dictionary that contains the distance to a tile if it is less than max_dist
# and otherwise INF or is empty.
var dist: Dictionary[Vector2i, int] = {}
var prev: Dictionary[Vector2i, Tile] = {}


var unvisited: Dictionary[int, Array] = {}
var max_dist: int
var start_pos: Vector2i
var owning_char: GridCharacter

const MAX_INT = (1 << 63)-1

# Run djkstra's on init
func _init(mdist: int, character: GridCharacter) -> void:
	max_dist = mdist
	start_pos = character.pos
	owning_char = character
	dist[start_pos] = 0
	prev[start_pos] = null
	for i in range(1, max_dist+1):
		unvisited[i] = []
	explore(grid.get_tile(start_pos))
	var next_tile: Tile = get_next()
	while next_tile != null:
		explore(next_tile)
		next_tile = get_next()
	

	
func get_next() -> Tile:
	for i in range(1, max_dist+1):
		if unvisited[i].is_empty():
			continue
		return unvisited[i].pop_front()
	return null


# TODO: Add function to let tiles change movability based on char,
# Add support for impassable tiles
func explore(base_tile: Tile) -> void:
	var adjacent: Array[Tile] = base_tile.get_adjacent()
	for adj_tile: Tile in adjacent:
		if !adj_tile.can_walk_through(owning_char):
			continue
		var adj_pos: Vector2i = adj_tile.pos
		var new_dist: int = base_tile.move_cost + dist[base_tile.pos]
		# We aren't loading the tiles at init as most tiles on the grid will not be accessed
		# So we must get_or_add here to load adjacent
		if get_dist(adj_pos) > new_dist:
			if !unvisited.has(new_dist):
				# Tile is beyond max_dist
				continue
			unvisited[new_dist].append(adj_tile)
			dist[adj_pos] = base_tile.move_cost + dist[base_tile.pos]
			prev[adj_pos] = base_tile


## Returns an Array with the position of all reachable tiles
func get_reachable_posses() -> Array[Vector2i]:
	var posses: Array[Vector2i] = []
	for key: Vector2i in dist.keys():
		if dist[key] != MAX_INT and can_end_on(grid.get_tile(key)):
			posses.append(key)
	return posses

## Returns an Array with all reachable tiles
func get_reachable_tiles() -> Array[Tile]:
	var pos_to_tile: Callable = func(pos: Vector2i) -> Tile: 
		return grid.get_tile(pos)
	var reachable: Array = get_reachable_posses().map(pos_to_tile)
	var reachable_tiles: Array[Tile]
	reachable_tiles.assign(reachable)
	return reachable_tiles


func is_reachable(pos: Vector2i) -> bool:
	# some dists will be MAX_INT already. Any tile with a dist that isn't, is reachable 
	return get_dist(pos) != MAX_INT

func get_dist(pos: Vector2i) -> int:
	return dist.get_or_add(pos, MAX_INT)

func can_end_on(tile: Tile) -> bool:
	return tile.pos != start_pos and tile.can_end_on(owning_char) and is_reachable(tile.pos)
