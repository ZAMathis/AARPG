class_name Hitbox extends Area2D

signal Damaged(damage: int)

func take_damage(damage: int) -> void:
	print("oof ", damage)
	Damaged.emit(damage)
