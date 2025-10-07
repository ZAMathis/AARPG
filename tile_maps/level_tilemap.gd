class_name LevelTilemap extends TileMap

func _ready() -> void:
	LevelManager.change_tilemap_bounds(get_tilemap_bounds())

func get_tilemap_bounds() -> Array[ Vector2 ]:
	var bounds: Array[ Vector2 ] = []
	bounds.append(
		# top left
		Vector2(get_used_rect().position * tile_set.tile_size)
	)
	bounds.append(
		# bottom right
		Vector2(get_used_rect().end * tile_set.tile_size)
	)
	return bounds
