@tool
extends ProgressBar
class_name SmoothBar

@export var trueValue := max_value/2
@export_range(0.0,1.0) var smoothness := 0.5

func _process(delta: float) -> void:
	value = move_toward(value, trueValue, smoothness)
