extends GridCharacter

class_name Sally;

func _ready() -> void:
	super._ready()
	speed = 4

func _on_clickable_hitbox_clicked() -> void:
	InstanceHandler.active_grid.move_entity(self, self.pos+Vector2i(-1, 1))
