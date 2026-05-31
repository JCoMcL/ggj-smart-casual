extends TileEntity

func grid_update():
	var grid_pos = grid.get_object_grid_pos(self)
	var infront = grid.get_at_pos(grid_pos.x +1, grid_pos.y)
	if infront is TileEntity:
		grid.move(infront, Vector3.RIGHT)
