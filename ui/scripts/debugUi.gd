extends VBoxContainer
class_name DebugUI

@onready var fpsCounter : Label = $FPS
@onready var ftCounter : Label = $FT

func _process(delta: float) -> void:
	fpsCounter.text = str("FPS: ", Engine.get_frames_per_second())
	ftCounter.text = str("FT: ", delta)
