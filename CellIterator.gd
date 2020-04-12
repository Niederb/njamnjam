class_name CellIterator

var cell
var visited = false
var cell_coordinates
var sub_graph_id = -1

func init(cell, cell_coordinates):
	self.cell = cell
	self.cell_coordinates = cell_coordinates

func is_visited():
	return visited
