extends Node2D

@onready var rayGrid = %RayGrid
@onready var prismGrid = %PrismGrid
@onready var gridArray = rayGrid.get_children()
var grid2DArray: Array[Array]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var counter = 0
	grid2DArray.append([])
	grid2DArray.append([])
	grid2DArray.append([])
	grid2DArray.append([])
	grid2DArray.append([])
	for i in gridArray:
		if counter < 5:
			grid2DArray[0].append(i)
		elif counter >= 5 and counter < 10:
			grid2DArray[1].append(i)
		elif counter >= 10 and counter < 15:
			grid2DArray[2].append(i)
		elif counter >= 15 and counter < 20:
			grid2DArray[3].append(i)
		elif counter >= 20 and counter < 25:
			grid2DArray[4].append(i)
		counter += 1
	updateLight()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func updateLight():
	for x in gridArray:
		x.clearLines()
	for i in range(5):
		for j in range(5):
			if grid2DArray[i][j].source != [0,0]:
				if grid2DArray[i][j].prismSlot == null:
					if grid2DArray[i][j].source[1] == 1:
						grid2DArray[i][j].vert = [grid2DArray[i][j].source[0],1]
						grid2DArray[i][j].drawLine()
						rayDown(i,j,grid2DArray[i][j].source[0])
					elif grid2DArray[i][j].source[1] == 2:
						grid2DArray[i][j].hor = [grid2DArray[i][j].source[0],1]
						grid2DArray[i][j].drawLine()
						rayLeft(i,j,grid2DArray[i][j].source[0])
					elif grid2DArray[i][j].source[1] == 3:
						grid2DArray[i][j].vert = [grid2DArray[i][j].source[0],2]
						grid2DArray[i][j].drawLine()
						rayUp(i,j,grid2DArray[i][j].source[0])
					elif grid2DArray[i][j].source[1] == 4:
						grid2DArray[i][j].hor = [grid2DArray[i][j].source[0],2]
						grid2DArray[i][j].drawLine()
						rayRight(i,j,grid2DArray[i][j].source[0])
				elif grid2DArray[i][j].prismSlot.has_method("mirror"):
					if grid2DArray[i][j].source[1] == 1:
						if grid2DArray[i][j].prismSlot.direc == 1:
							grid2DArray[i][j].tr = [grid2DArray[i][j].source[0],1]
							grid2DArray[i][j].drawLine()
							rayRight(i,j,grid2DArray[i][j].source[0])
						elif grid2DArray[i][j].prismSlot.direc == 4:
							grid2DArray[i][j].lt = [grid2DArray[i][j].source[0],2]
							grid2DArray[i][j].drawLine()
							rayLeft(i,j,grid2DArray[i][j].source[0])
					elif grid2DArray[i][j].source[1] == 2:
						if grid2DArray[i][j].prismSlot.direc == 1:
							grid2DArray[i][j].tr = [grid2DArray[i][j].source[0],2]
							grid2DArray[i][j].drawLine()
							rayUp(i,j,grid2DArray[i][j].source[0])
						elif grid2DArray[i][j].prismSlot.direc == 2:
							grid2DArray[i][j].rb = [grid2DArray[i][j].source[0],2]
							grid2DArray[i][j].drawLine()
							rayDown(i,j,grid2DArray[i][j].source[0])
					elif grid2DArray[i][j].source[1] == 3:
						if grid2DArray[i][j].prismSlot.direc == 2:
							grid2DArray[i][j].rb = [grid2DArray[i][j].source[0],2]
							grid2DArray[i][j].drawLine()
							rayRight(i,j,grid2DArray[i][j].source[0])
						elif grid2DArray[i][j].prismSlot.direc == 3:
							grid2DArray[i][j].bl = [grid2DArray[i][j].source[0],1]
							grid2DArray[i][j].drawLine()
							rayLeft(i,j,grid2DArray[i][j].source[0])
					elif grid2DArray[i][j].source[1] == 4:
						if grid2DArray[i][j].prismSlot.direc == 3:
							grid2DArray[i][j].bl = [grid2DArray[i][j].source[0],2]
							grid2DArray[i][j].drawLine()
							rayDown(i,j,grid2DArray[i][j].source[0])
						elif grid2DArray[i][j].prismSlot.direc == 4:
							grid2DArray[i][j].lt = [grid2DArray[i][j].source[0],1]
							grid2DArray[i][j].drawLine()
							rayUp(i,j,grid2DArray[i][j].source[0])


func rayDown(i,j,colour):
	i += 1
	if i < 5:
		if grid2DArray[i][j].prismSlot == null:
			grid2DArray[i][j].vert = [colour,1]
			grid2DArray[i][j].drawLine()
			rayDown(i,j,colour)
		elif grid2DArray[i][j].prismSlot.has_method("mirror"):
			if grid2DArray[i][j].prismSlot.direc == 1:
				grid2DArray[i][j].tr = [colour,1]
				grid2DArray[i][j].drawLine()
				rayRight(i,j,colour)
			elif (grid2DArray[i][j].prismSlot.direc == 2) or (grid2DArray[i][j].prismSlot.direc == 3):
				pass
			elif grid2DArray[i][j].prismSlot.direc == 4:
				grid2DArray[i][j].lt = [colour,2]
				grid2DArray[i][j].drawLine()
				rayLeft(i,j,colour)
		elif grid2DArray[i][j].prismSlot.has_method("splitter"):
			if grid2DArray[i][j].prismSlot.direc == 1:
				if (colour == 2) or (colour == 3) or (colour == 4):
					grid2DArray[i][j].vert = [colour,1]
					grid2DArray[i][j].drawLine()
					rayDown(i,j,colour)
				elif colour == 5:
					grid2DArray[i][j].tr = [3,1]
					grid2DArray[i][j].lt = [2,2]
					grid2DArray[i][j].drawLine()
					rayRight(i,j,3)
					rayLeft(i,j,2)
				elif colour == 6:
					grid2DArray[i][j].tr = [3,1]
					grid2DArray[i][j].lt = [4,2]
					grid2DArray[i][j].drawLine()
					rayRight(i,j,3)
					rayLeft(i,j,4)
				elif colour == 7:
					grid2DArray[i][j].tr = [2,1]
					grid2DArray[i][j].lt = [4,2]
					grid2DArray[i][j].drawLine()
					rayRight(i,j,2)
					rayLeft(i,j,4)
		elif grid2DArray[i][j].prismSlot.has_method("filter"):
			if grid2DArray[i][j].prismSlot.direc == 1:
				pass

func rayLeft(i,j,colour):
	j -= 1
	if j > -1:
		if grid2DArray[i][j].prismSlot == null:
			grid2DArray[i][j].hor = [colour,1]
			grid2DArray[i][j].drawLine()
			rayLeft(i,j,colour)
		elif grid2DArray[i][j].prismSlot.has_method("mirror"):
			if grid2DArray[i][j].prismSlot.direc == 1:
				grid2DArray[i][j].tr = [colour,2]
				grid2DArray[i][j].drawLine()
				rayUp(i,j,colour)
			elif (grid2DArray[i][j].prismSlot.direc == 3) or (grid2DArray[i][j].prismSlot.direc == 4):
				pass
			elif grid2DArray[i][j].prismSlot.direc == 2:
				grid2DArray[i][j].rb = [colour,1]
				grid2DArray[i][j].drawLine()
				rayDown(i,j,colour)
		elif grid2DArray[i][j].prismSlot.has_method("splitter"):
			if grid2DArray[i][j].prismSlot.direc == 2:
				if (colour == 2) or (colour == 3) or (colour == 4):
					grid2DArray[i][j].hor = [colour,1]
					grid2DArray[i][j].drawLine()
					rayLeft(i,j,colour)
				elif colour == 5:
					grid2DArray[i][j].tr = [3,2]
					grid2DArray[i][j].rb = [2,1]
					grid2DArray[i][j].drawLine()
					rayUp(i,j,3)
					rayDown(i,j,2)
				elif colour == 6:
					grid2DArray[i][j].tr = [3,2]
					grid2DArray[i][j].rb = [4,1]
					grid2DArray[i][j].drawLine()
					rayUp(i,j,3)
					rayDown(i,j,4)
				elif colour == 7:
					grid2DArray[i][j].tr = [2,2]
					grid2DArray[i][j].rb = [4,1]
					grid2DArray[i][j].drawLine()
					rayUp(i,j,2)
					rayDown(i,j,4)

func rayUp(i,j,colour):
	i -= 1
	if i > -1:
		if grid2DArray[i][j].prismSlot == null:
			grid2DArray[i][j].vert = [colour,2]
			grid2DArray[i][j].drawLine()
			rayUp(i,j,colour)
		elif grid2DArray[i][j].prismSlot.has_method("mirror"):
			if grid2DArray[i][j].prismSlot.direc == 2:
				grid2DArray[i][j].rb = [colour,2]
				grid2DArray[i][j].drawLine()
				rayRight(i,j,colour)
			elif (grid2DArray[i][j].prismSlot.direc == 1) or (grid2DArray[i][j].prismSlot.direc == 4):
				pass
			elif grid2DArray[i][j].prismSlot.direc == 3:
				grid2DArray[i][j].bl = [colour,1]
				grid2DArray[i][j].drawLine()
				rayLeft(i,j,colour)
		elif grid2DArray[i][j].prismSlot.has_method("splitter"):
			if grid2DArray[i][j].prismSlot.direc == 3:
				if (colour == 2) or (colour == 3) or (colour == 4):
					grid2DArray[i][j].vert = [colour,2]
					grid2DArray[i][j].drawLine()
					rayUp(i,j,colour)
				elif colour == 5:
					grid2DArray[i][j].rb = [3,2]
					grid2DArray[i][j].bl = [2,1]
					grid2DArray[i][j].drawLine()
					rayRight(i,j,3)
					rayLeft(i,j,2)
				elif colour == 6:
					grid2DArray[i][j].rb = [3,2]
					grid2DArray[i][j].bl = [4,1]
					grid2DArray[i][j].drawLine()
					rayRight(i,j,3)
					rayLeft(i,j,4)
				elif colour == 7:
					grid2DArray[i][j].rb = [2,2]
					grid2DArray[i][j].bl = [4,1]
					grid2DArray[i][j].drawLine()
					rayRight(i,j,2)
					rayLeft(i,j,4)

func rayRight(i,j,colour):
	j += 1
	if j < 5:
		if grid2DArray[i][j].prismSlot == null:
			grid2DArray[i][j].hor = [colour,2]
			grid2DArray[i][j].drawLine()
			rayRight(i,j,colour)
		elif grid2DArray[i][j].prismSlot.has_method("mirror"):
			if grid2DArray[i][j].prismSlot.direc == 3:
				grid2DArray[i][j].bl = [colour,2]
				grid2DArray[i][j].drawLine()
				rayDown(i,j,colour)
			elif (grid2DArray[i][j].prismSlot.direc == 1) or (grid2DArray[i][j].prismSlot.direc == 2):
				pass
			elif grid2DArray[i][j].prismSlot.direc == 4:
				grid2DArray[i][j].lt = [colour,1]
				grid2DArray[i][j].drawLine()
				rayUp(i,j,colour)
		elif grid2DArray[i][j].prismSlot.has_method("splitter"):
			if grid2DArray[i][j].prismSlot.direc == 4:
				if (colour == 2) or (colour == 3) or (colour == 4):
					grid2DArray[i][j].hor = [colour,1]
					grid2DArray[i][j].drawLine()
					rayRight(i,j,colour)
				elif colour == 5:
					grid2DArray[i][j].lt = [3,1]
					grid2DArray[i][j].bl = [2,2]
					grid2DArray[i][j].drawLine()
					rayUp(i,j,3)
					rayDown(i,j,2)
				elif colour == 6:
					grid2DArray[i][j].lt = [3,1]
					grid2DArray[i][j].bl = [4,2]
					grid2DArray[i][j].drawLine()
					rayUp(i,j,3)
					rayDown(i,j,4)
				elif colour == 7:
					grid2DArray[i][j].lt = [2,1]
					grid2DArray[i][j].bl = [4,2]
					grid2DArray[i][j].drawLine()
					rayUp(i,j,2)
					rayDown(i,j,4)
