@tool
extends Node3D
class_name Room


@export var area : Area
@export var id := 0

@export var cameraArea : Vector4 = Vector4(0,0,0,0)

func _ready() -> void:
	if get_tree().current_scene == self:
		var sceneRes : PackedScene = load("res://scenes/gameplay.tscn")
		var sceneNode : GameManager = sceneRes.instantiate()
		sceneNode.roomManager.change_room(self.duplicate())
		get_tree().change_scene_to_node(sceneNode)

func draw_debug():
	DebugDraw3D.scoped_config().set_thickness(.4)
	DebugDraw3D.draw_box_ab(
		Vector3(cameraArea.x, cameraArea.y, 0),
		Vector3(cameraArea.z, cameraArea.w, 0),
		Vector3.UP,
		Color.RED,
		false)
		
func _process(delta: float) -> void:
	if (Engine.is_editor_hint()):
		draw_debug();
