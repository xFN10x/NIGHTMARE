extends Node
class_name RoomManager

signal roomLoaded(room : Room)

var _currentRoom : Room
var _currentArea : Area

var _lastArea : Area
var _loaded := false
var _roomEnterLoc := Vector3.ZERO

@onready var uiAnimations : AnimationPlayer = $"../UI/UIAnimations"
@onready var areaNameLabel : Label = $"../UI/CenteredUI/AreaName"
@onready var gameManager : GameManager = get_tree().current_scene

func transition_to_room_path(roomPath : String,  destinationExitId := -1):
	gameManager.player.controlsEnabled = false
	uiAnimations.play("fadeOut")
	await timer(0.7)
	change_room_path(roomPath, destinationExitId)
	uiAnimations.play("fadeIn")
	await timer(0.5)
	gameManager.player.controlsEnabled = true
	
func change_room_path(roomPath : String, destinationExitId := -1):
	return change_room((load(roomPath) as PackedScene).instantiate(), destinationExitId)
	
func change_room(room : Room, destinationExitId := -1):
	if _loaded:
		gameManager.remove_child(_currentRoom)
	_currentRoom = room
	var targetExit := room.get_room_exit(destinationExitId)
	_roomEnterLoc = targetExit.position if targetExit != null else room.defaultPlayerPosition
	_loaded = false;

func get_room() -> Room:
	return _currentRoom

func _process(delta: float) -> void:
	if not _loaded && _currentRoom != null:
		add_sibling(_currentRoom)
		gameManager.player.position = _roomEnterLoc
		_loaded = true
		if not _lastArea == _currentRoom.area:
			areaNameLabel.text = _currentRoom.area.name
			uiAnimations.play("areaPopup")
		_lastArea = _currentRoom.area
		roomLoaded.emit(_currentRoom)

func timer(leng: float) -> Signal:
	return get_tree().create_timer(leng).timeout
