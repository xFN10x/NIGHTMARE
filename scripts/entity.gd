extends CharacterBody3D
class_name Entity

@export_category("Statistics")
@export var speed := 10.0
@export var jumpVel := 20.0
@export var maximumVelocity := 50

@export var maxHealth := 100.0
@export var health := 100.0:
	set(val):
		val = clamp(val, 0, maxHealth)

@export_category("Visual")
@export var entitySprite : Sprite3D
@export var entityVisual : EntityVisual
@onready var entityVisualAniTree : AnimationTree = entityVisual.animationTree
@onready var entityVisualPlayback : AnimationNodeStateMachinePlayback = entityVisualAniTree["parameters/playback"]
@onready var initLoc := position

var wasOnFloor := false;

## set to true to jump next frame
var jump := false

func _ready() -> void:
	entityVisualAniTree.advance_expression_base_node = get_path()
	
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity.y = clamp(velocity.y + (get_gravity().y * delta), -maximumVelocity, maximumVelocity)
	
	# Handle jump.
	if jump and jumpVel != 0 and is_on_floor():
		jump = false
		velocity.y = jumpVel
	entityVisualAniTree.set("parameters/verticleVel/blend_position", velocity.y)
	
	entityVisualAniTree.set("parameters/conditions/isnt_airborne", is_on_floor())
	entityVisualAniTree.set("parameters/conditions/is_airborne", !is_on_floor())

	if (wasOnFloor and not is_on_floor()):
		entityVisualPlayback.travel("verticleVel")
	wasOnFloor = is_on_floor()
	move_and_slide()

func move(movement : float):
	var blend := absf(movement)
	entityVisualAniTree.set("parameters/idleToWalk/blend_position", blend)
	if (movement != 0):
		entitySprite.flip_h = movement < 0
	velocity.x = movement * speed
