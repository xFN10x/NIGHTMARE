extends CharacterBody3D
class_name PlayerController

@export var speed := 8.0
@export var jumpVel := 10
@export var maximumVelocity := 50

@export var playerSprite : Sprite3D
@export var playerVisual : Node2D
@onready var playerVisualAniTree : AnimationTree = playerVisual.get_node("AnimationTree")

@onready var initLoc := position

func _ready() -> void:
	playerVisualAniTree.advance_expression_base_node = get_path()

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity.y = clamp(velocity.y + (get_gravity().y * delta), -maximumVelocity, maximumVelocity)
		
	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jumpVel
	playerVisualAniTree.set("parameters/verticleVel/blend_position", velocity.y)
	
	playerVisualAniTree.set("parameters/conditions/isnt_airborne", is_on_floor())
	playerVisualAniTree.set("parameters/conditions/is_airborne", !is_on_floor())

	## Get the input direction and handle the movement/deceleration.
	## As good practice, you should replace UI actions with custom gameplay actions.
	#var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	#var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	#if direction:
		#velocity.x = direction.x * SPEED
	#else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)
	var movement := Input.get_axis("moveL", "moveR")
	var blend := absf(movement)
	playerVisualAniTree.set("parameters/idleToWalk/blend_position", blend)
	if (movement != 0):
		playerSprite.flip_h = movement < 0
	velocity.x = movement * speed

	move_and_slide()
