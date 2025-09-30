class_name State_Attack extends State

var is_attacking: bool = false

@onready var animation_player: AnimationPlayer = %AnimationPlayer
@onready var walk_state: State = $"../Walk"
@onready var idle_state: State = $"../Idle"

# what happens when a player enters this state
func enter() -> void:
	player.update_animation("attack")
	animation_player.animation_finished.connect(end_attack)
	is_attacking = true
	pass
	
# same as above but on exit
func exit() -> void:
	pass
	
# for what happens during the _process update in this state
func process(_delta: float) -> State:
	player.velocity = Vector2.ZERO
	
	if is_attacking == false:
		if player.input_direction == Vector2.ZERO:
			return idle_state
		else:
			return walk_state
	return null

# for what happens during the _physics_process update in this state
func physics_process(_delta: float) -> State:
	return null

# for what happens during input events in this state
func handle_input(_event: InputEvent) -> State:
	return null
	
func end_attack(_new_animation_name: String) -> void:
	is_attacking = false
