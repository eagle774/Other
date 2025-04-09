extends Resource
class_name EffectCluster

var effects: Array[BaseEffect]


func _init() -> void:
	effects = []


## Add the given effect to the cluster
func add_effect(effect: BaseEffect) -> void:
	effects.append(effect)
