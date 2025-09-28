class_name State extends Node

static var player: Player

func _ready() -> void:
	pass

# what happens when a player enters this state
func enter() -> void:
	pass
	
# same as above but on exit
func exit() -> void:
	pass
	
# for what happens during the _process update in this state
func process(_delta: float) -> State:
	return null

# for what happens during the _physics_process update in this state
func physics_process(_delta: float) -> State:
	return null

# for what happens during input events in this state
func handle_input(_event: InputEvent) -> State:
	return null
