@tool
extends Area3D
class_name RoomExit

@export var exitID : int
@export var direction : Vector3

@export_file("*.tscn") var destination : String
@export var destinationExitID : int 

@onready var gameManager : GameManager 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	monitoring = true
	var root = get_tree().current_scene
	if (root is GameManager):
		gameManager = root
	body_entered.connect(entered)

func entered(body: Node3D):
	if body is PlayerController and body.controlsEnabled and destination != null:
		body.controlsEnabled = false
		gameManager.roomManager.transition_to_room_path(destination, destinationExitID)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (Engine.is_editor_hint()):
		_draw_debug()

func _draw_debug():
	var normalDir := direction.normalized()
	DebugDraw3D.scoped_config().set_thickness(0)
	DebugDraw3D.draw_arrow_ray(position - (normalDir * 3), normalDir, 3, Color.AQUA)
