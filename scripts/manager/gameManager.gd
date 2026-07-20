extends Node
class_name GameManager

@export var camera : CameraController
@export var player : PlayerController
@export var roomManager : RoomManager
 
@onready var debugUi := $UI/DebugLabels
@onready var uiAnimations := $UI/UIAnimations

func _enter_tree() -> void:
	var block := $UI/BlackOverlay
	block.color = Color.BLACK
	block.visible = true;
	roomManager.roomLoaded.connect(func(room):
		block.visible = false;
		, CONNECT_ONE_SHOT)
	if roomManager.get_room() == null:
		roomManager.change_room_path("res://scenes/rooms/test_room.tscn", -1)
