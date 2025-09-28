class_name State_Walk extends State

@export var movement_speed: float = 125.0

@onready var idle_state: State = $"../Idle"

# what happens when a player enters this state
func enter() -> void:
	player.update_animation("walk")
	pass
	
# same as above but on exit
func exit() -> void:
	pass
	
# for what happens during the _process update in this state
func process(_delta: float) -> State:
	if player.input_direction == Vector2.ZERO:
		return idle_state
	
	player.velocity = player.input_direction * movement_speed
	
	if player.set_direction():
		player.update_animation("walk")
	
	return null

# for what happens during the _physics_process update in this state
func physics_process(_delta: float) -> State:
	return null

# for what happens during input events in this state
func handle_input(_event: InputEvent) -> State:
	return null
