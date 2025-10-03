class_name State_Attack extends State

var is_attacking: bool = false

@export var attack_sound: AudioStream

@onready var animation_player: AnimationPlayer = %AnimationPlayer
@onready var attack_anim_player: AnimationPlayer = $"../../PlayerSprite/AttackEffectSprite/AttackAnimationPlayer"
@onready var audio_player: AudioStreamPlayer2D = $"../../Audio/AudioStreamPlayer2D"
@onready var walk_state: State = $"../Walk"
@onready var idle_state: State = $"../Idle"
@onready var hurt_box: HurtBox = $"../../Interaction/HurtBox"

# what happens when a player enters this state
func enter() -> void:
	player.update_animation("attack")
	attack_anim_player.play("attack_%s" % player.anim_direction())
	animation_player.animation_finished.connect(end_attack)
	is_attacking = true
	
	#hurtbox
	await get_tree().create_timer(0.075).timeout
	hurt_box.monitoring = true
	
	# audio
	audio_player.stream = attack_sound
	audio_player.pitch_scale = randf_range(0.9, 1.1)
	audio_player.play()
	pass
	
# same as above but on exit
func exit() -> void:
	animation_player.animation_finished.disconnect(end_attack)
	is_attacking = false
	hurt_box.monitoring = false
	pass
	
# for what happens during the _process update in this state
func process(_delta: float) -> State:
	player.velocity -= (player.velocity * 10) * _delta
	
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
