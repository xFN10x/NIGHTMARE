extends Node
class_name RoomManager

var _currentRoom : Room
var _currentArea : Area

var _lastArea : Area
var _loaded := false

@onready var uiAnimations : AnimationPlayer = $"../UI/UIAnimations"
@onready var areaNameLabel : Label = $"../UI/CenteredUI/AreaName"

func change_room(room : Room):
	_currentRoom = room
	_loaded = false;
	
func get_room() -> Room:
	return _currentRoom

func _process(delta: float) -> void:
	if not _loaded && _currentRoom != null:
		add_sibling(_currentRoom)
		_loaded = true
		if not _lastArea == _currentRoom.area:
			areaNameLabel.text = _currentRoom.area.name
			uiAnimations.play("areaPopup")
