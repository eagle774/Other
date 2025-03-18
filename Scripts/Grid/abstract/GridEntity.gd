extends Node2D

class_name GridEntity;

var y: Grid;

var hp := 5;
var maxHP := hp;
var pos: Vector2i;
var multi_tile: bool;
var team: int = 0;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	position = InstanceHandler.active_grid.calc_position(pos)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position = InstanceHandler.active_grid.calc_position(pos)

func can_walk_through(other: GridEntity) -> bool:
	return other.team == self.team
