extends Camera3D
class_name CameraController

@export var plr: PlayerController;

@export var initZ := 15


func _ready() -> void:
	pass


func _physics_process(delta: float) -> void:
	var pPos := position.lerp(plr.position, .1)
	pPos.z = initZ
	pPos.y += .3
	position = pPos

func _process(delta: float) -> void:
	pass
