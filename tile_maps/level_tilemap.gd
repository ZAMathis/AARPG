class_name LevelTilemap extends TileMap

func _ready() -> void:
	LevelManager.change_tilemap_bounds(get_tilemap_bounds())

func get_tilemap_bounds() -> Array[ Vector2 ]:
	var bounds: Array[ Vector2 ] = []
	
	# Get the bounds in local tile coordinates
	var local_top_left = Vector2(get_used_rect().position * tile_set.tile_size)
	var local_bottom_right = Vector2(get_used_rect().end * tile_set.tile_size)
	
	# Apply the tilemap's scale to get world coordinates
	bounds.append(local_top_left * scale)
	bounds.append(local_bottom_right * scale)
	
	return bounds
