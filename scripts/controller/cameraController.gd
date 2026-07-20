extends Camera3D
class_name CameraController

@onready var gameManager : GameManager = $".."
@onready var plr := gameManager.player
@onready var block := $"../UI/BlackOverlay"

@export var initZ := 15.0
@export var offsetY := .3
@export var cameraSpeed := 1.0

func _physics_process(delta: float) -> void:
	# sets the pos for the next frame to be lerped if you can see,
	# and it doesn't lerp when you cant see
	var pPos : Vector3 = position.lerp(plr.position, cameraSpeed/10) if not block.visible and block.color == Color.BLACK else plr.position
	pPos.z = initZ
	pPos.y += offsetY
	var currentRoom := gameManager.roomManager.get_room()
	if currentRoom and currentRoom.cameraAreaEnabled:
		var cameraArea := currentRoom.cameraArea
		position = pPos.clamp(Vector3(cameraArea.x, cameraArea.y, initZ), Vector3(cameraArea.z, cameraArea.w, initZ))
	else:
		position = pPos
