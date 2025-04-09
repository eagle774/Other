extends BaseEffect
class_name DamageEffect


var damage: float = 0
var target: GridEntity

## A damage effect deals damage idamage to target itarget
func _init(itarget: GridEntity, idamage: float) -> void:
	damage = idamage
	target = itarget
	
func on_enacted() -> void:
	pass
