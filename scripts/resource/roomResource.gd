extends Resource
class_name RoomResource

@export var scene : PackedScene

func get_room() -> Room:
	return scene.instantiate()
