extends Entity
class_name PlayerController

@export var controlsEnabled := true

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("jump") and controlsEnabled and is_on_floor():
		jump = true
	if controlsEnabled:
		var movement := Input.get_axis("moveL", "moveR")
		move(movement)
	super(delta);
