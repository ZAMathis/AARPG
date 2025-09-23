class_name Player extends CharacterBody2D

const MOVEMENT_SPEED: float = 10000.0

func _process(delta: float) -> void:
	var input_direction: Vector2 = Input.get_vector("left","right","up","down")
	velocity = (input_direction * MOVEMENT_SPEED) * delta
	

func _physics_process(delta: float) -> void:
	move_and_slide()
