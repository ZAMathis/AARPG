class_name Player extends CharacterBody2D


var input_direction: Vector2 = Vector2.ZERO
var cardinal_direction: Vector2 = Vector2.ZERO

@onready var state_machine: PlayerStateMachine = $StateMachine

# For player interactions in player_interactions script
signal DirectionChanged(new_direction: Vector2)

func _ready() -> void:
	state_machine.init(self)

func _process(delta: float) -> void:
	input_direction = Input.get_vector("left","right","up","down")
	# print("Player pos: ", global_position)
	pass
	
func _physics_process(delta: float) -> void:
	move_and_slide()
	
func set_direction() -> bool:
	if input_direction == Vector2.ZERO:
		return false
	
	var new_direction: Vector2 = cardinal_direction
		
	if input_direction.y == 0:
		new_direction = Vector2.LEFT if input_direction.x < 0 else Vector2.RIGHT
	elif input_direction.x == 0:
		new_direction = Vector2.UP if input_direction.y < 0 else Vector2.DOWN
		
	if new_direction == cardinal_direction:
		return false
		
	cardinal_direction = new_direction
	DirectionChanged.emit(new_direction)
	$PlayerSprite.scale.x = -1 if cardinal_direction == Vector2.LEFT else 1
	return true
	
func update_animation(state: String) -> void:
	%AnimationPlayer.play(state + "_" + anim_direction())

func anim_direction() -> String:
	if cardinal_direction == Vector2.DOWN:
		return "down"
	elif cardinal_direction == Vector2.UP:
		return "up"
	else:
		return "side"
	
