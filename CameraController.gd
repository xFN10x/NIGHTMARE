extends Camera3D
class_name CameraController

@export var plr: PlayerController;

@export var initZ := 15.0
@export var offsetY := .3
@export var cameraSpeed := 1.0


func _ready() -> void:
	pass


func _physics_process(delta: float) -> void:
	var pPos := position.lerp(plr.position, cameraSpeed/10)
	pPos.z = initZ
	pPos.y += offsetY
	position = pPos
