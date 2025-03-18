extends GridCharacter

class_name Timmy;


func _ready() -> void:
	super._ready()
	speed = 6

func _on_clickable_hitbox_clicked() -> void:
	print("Hello, human resources?")
