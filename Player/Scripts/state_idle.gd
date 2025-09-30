class_name State_Idle extends State

@onready var walk_state: State = $"../Walk"
@onready var attack_state: State = $"../Attack"

# what happens when a player enters this state
func enter() -> void:
	player.update_animation("idle")
	pass
	
# same as above but on exit
func exit() -> void:
	pass
	
# for what happens during the _process update in this state
func process(_delta: float) -> State:
	if player.input_direction != Vector2.ZERO:
		return walk_state
	player.velocity = Vector2.ZERO
	return null

# for what happens during the _physics_process update in this state
func physics_process(_delta: float) -> State:
	return null

# for what happens during input events in this state
func handle_input(_event: InputEvent) -> State:
	if _event.is_action_pressed("attack"):
		return attack_state
	return null
