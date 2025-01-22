extends Node2D

class_name GridEntity;

var y: Grid;

var hp := 5;
var maxHP := hp;
var pos := Vector2();

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func on_turn() -> void:
	pass



# as with all things, most issue stem from vagueness or a lack of direction/
# maybe not right before bed........
# laser skirmish but as an autochess.
# characters are positioned on the left 
# we still need to figure out combat mechanics.
# how do characters fight?
# .............. rpg mechanics
