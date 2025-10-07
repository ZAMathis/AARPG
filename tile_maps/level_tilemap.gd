class_name LevelTilemap extends TileMap

func _ready() -> void:
	LevelManager.change_tilemap_bounds(get_tilemap_bounds())
	call_deferred("create_border_collision")

func get_tilemap_bounds() -> Array[ Vector2 ]:
	var bounds: Array[ Vector2 ] = []
	
	var local_top_left = Vector2(get_used_rect().position * tile_set.tile_size)
	var local_bottom_right = Vector2(get_used_rect().end * tile_set.tile_size)
	
	bounds.append(local_top_left * scale)
	bounds.append(local_bottom_right * scale)
	
	return bounds

# collision borders
func create_border_collision() -> void:
	var bounds = get_tilemap_bounds()
	var top_left = bounds[0]
	var bottom_right = bounds[1]
	
	print("Creating borders at: ", top_left, " to ", bottom_right)
	
	var border_thickness = 64.0
	
	var border_body = StaticBody2D.new()
	border_body.collision_layer = 16 
	border_body.collision_mask = 0
	border_body.name = "TilemapBorders"
	
	create_border_rect(border_body, 
		Vector2((top_left.x + bottom_right.x) / 2, top_left.y - border_thickness / 2),
		Vector2(bottom_right.x - top_left.x, border_thickness), "Top")
	
	create_border_rect(border_body,
		Vector2((top_left.x + bottom_right.x) / 2, bottom_right.y + border_thickness / 2),
		Vector2(bottom_right.x - top_left.x, border_thickness), "Bottom")
	
	create_border_rect(border_body,
		Vector2(top_left.x - border_thickness / 2, (top_left.y + bottom_right.y) / 2),
		Vector2(border_thickness, bottom_right.y - top_left.y), "Left")
	
	create_border_rect(border_body,
		Vector2(bottom_right.x + border_thickness / 2, (top_left.y + bottom_right.y) / 2),
		Vector2(border_thickness, bottom_right.y - top_left.y), "Right")
	
	get_parent().add_child(border_body)
	border_body.owner = get_tree().edited_scene_root if Engine.is_editor_hint() else get_parent()
	
	print("Border body added with ", border_body.get_child_count(), " collision shapes")

func create_border_rect(parent: StaticBody2D, pos: Vector2, size: Vector2, name: String) -> void:
	var shape = CollisionShape2D.new()
	var rect = RectangleShape2D.new()
	rect.size = size
	shape.shape = rect
	shape.position = pos
	shape.name = name
	parent.add_child(shape)
	print(name, " border created at: ", pos, " size: ", size)
