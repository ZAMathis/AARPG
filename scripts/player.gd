class_name Player extends CharacterBody2D

const MOVEMENT_SPEED: float = 10000.0

var input_direction: Vector2 = Vector2.ZERO
var cardinal_direction: Vector2 = Vector2.ZERO
var state: String = "idle"

func _process(delta: float) -> void:
	input_direction = Input.get_vector("left","right","up","down")
	velocity = (input_direction * MOVEMENT_SPEED) * delta
	
	if set_state() || set_direction():
		update_animation()
	
func _physics_process(delta: float) -> void:
	move_and_slide()
	
func set_direction() -> bool:
	var new_direction: Vector2 = cardinal_direction
	
	if input_direction == Vector2.ZERO:
		return false
		
	if input_direction.y == 0:
		new_direction = Vector2.LEFT if input_direction.x < 0 else Vector2.RIGHT
	elif input_direction.x == 0:
		new_direction = Vector2.UP if input_direction.y < 0 else Vector2.DOWN
		
	if new_direction == cardinal_direction:
		return false
		
	cardinal_direction = new_direction
	$Sprite2D.scale.x = -1 if cardinal_direction == Vector2.LEFT else 1
	return true

func set_state() -> bool:
	var new_state: String = "idle" if input_direction == Vector2.ZERO else "walk"
	
	if new_state == state:
		return false
	state = new_state
	return true
	
func update_animation():
	%AnimationPlayer.play(state + "_" + anim_direction())

func anim_direction() -> String:
	if cardinal_direction == Vector2.DOWN:
		return "down"
	elif cardinal_direction == Vector2.UP:
		return "up"
	else:
		return "side"
	
