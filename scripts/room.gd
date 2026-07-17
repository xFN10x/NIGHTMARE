@tool
extends Node3D
class_name Room


@export var area : Area
@export var id := 0

@export var defaultPlayerPosition := Vector3.ZERO
@export var cameraAreaEnabled := false
@export var cameraArea : Vector4 = Vector4(0,0,0,0)

var _plrHitbox : BoxShape3D = load("res://misc/playerHitbox.tres")

func _ready() -> void:
	if get_tree().current_scene == self:
		var sceneRes : PackedScene = load("res://scenes/gameplay.tscn")
		var sceneNode : GameManager = sceneRes.instantiate()
		sceneNode.roomManager.change_room(self.duplicate())
		get_tree().change_scene_to_node(sceneNode)
		
func _process(delta: float) -> void:
	if (Engine.is_editor_hint()):
		draw_debug();

func draw_debug():
	DebugDraw3D.scoped_config().set_thickness(.05)
	DebugDraw3D.draw_box(defaultPlayerPosition - _plrHitbox.size/2, quaternion, _plrHitbox.size)
	if cameraAreaEnabled:
		DebugDraw3D.draw_box_ab(
			Vector3(cameraArea.x, cameraArea.y, 0),
			Vector3(cameraArea.z, cameraArea.w, 0),
			Vector3.UP,
			Color.RED,
			false)

func get_room_exit(id : int) -> RoomExit:
	var exits := find_children("", "RoomExit")
	if exits.is_empty(): return null;
	for exit : RoomExit in exits:
		if exit.exitID == id: return exit;
	return null
