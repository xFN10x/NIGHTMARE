extends Node2D
class_name EntityVisual

@export var animationTree : AnimationTree

func _get_configuration_warnings() -> PackedStringArray:
	return ["No animation tree is set!"] if animationTree == null else []
