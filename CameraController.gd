extends Camera3D
class_name CameraController

@export var plr: PlayerController;
@onready var gameManager : GameManager = $".."

@export var initZ := 15.0
@export var offsetY := .3
@export var cameraSpeed := 1.0

func _physics_process(delta: float) -> void:
	var pPos := position.lerp(plr.position, cameraSpeed/10)
	pPos.z = initZ
	pPos.y += offsetY
	var currentRoom := gameManager.roomManager.get_room()
	if currentRoom and currentRoom.cameraAreaEnabled:
		var cameraArea := currentRoom.cameraArea
		position = pPos.clamp(Vector3(cameraArea.x, cameraArea.y, initZ), Vector3(cameraArea.z, cameraArea.w, initZ))
	else:
		position = pPos
