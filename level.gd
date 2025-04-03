extends Node2D

@onready var rayGrid = %RayGrid
@onready var prismGrid = %PrismGrid
@onready var gridArray = rayGrid.get_children()
@export var levelNumber = 1
var grid2DArray: Array[Array]
var winArray: Array

var muteAudio = false
var win = false
signal win_show
signal win_hide

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
	winArray.clear()
	for x in gridArray:
		x.clearLines()
		if x.dest != [0,0]:
			winArray.append(x)
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
						mirror("down", i, j, grid2DArray[i][j].source[0])
					elif grid2DArray[i][j].source[1] == 2:
						mirror("left", i, j, grid2DArray[i][j].source[0])
					elif grid2DArray[i][j].source[1] == 3:
						mirror("up", i, j, grid2DArray[i][j].source[0])
					elif grid2DArray[i][j].source[1] == 4:
						mirror("right", i, j, grid2DArray[i][j].source[0])
				elif grid2DArray[i][j].prismSlot.has_method("splitter"):
					if grid2DArray[i][j].source[1] == 1:
						splitter("down", i, j, grid2DArray[i][j].source[0])
					elif grid2DArray[i][j].source[1] == 2:
						splitter("left", i, j, grid2DArray[i][j].source[0])
					elif grid2DArray[i][j].source[1] == 3:
						splitter("up", i, j, grid2DArray[i][j].source[0])
					elif grid2DArray[i][j].source[1] == 4:
						splitter("right", i, j, grid2DArray[i][j].source[0])
				elif grid2DArray[i][j].prismSlot.has_method("filter"):
					if grid2DArray[i][j].source[1] == 1:
						filter("down", i, j, grid2DArray[i][j].source[0])
					elif grid2DArray[i][j].source[1] == 2:
						filter("left", i, j, grid2DArray[i][j].source[0])
					elif grid2DArray[i][j].source[1] == 3:
						filter("up", i, j, grid2DArray[i][j].source[0])
					elif grid2DArray[i][j].source[1] == 4:
						filter("right", i, j, grid2DArray[i][j].source[0])
				elif grid2DArray[i][j].prismSlot.has_method("combiner"):
					if grid2DArray[i][j].source[1] == 1:
						combiner("down", i, j, grid2DArray[i][j].source[0])
					elif grid2DArray[i][j].source[1] == 2:
						combiner("left", i, j, grid2DArray[i][j].source[0])
					elif grid2DArray[i][j].source[1] == 3:
						combiner("up", i, j, grid2DArray[i][j].source[0])
					elif grid2DArray[i][j].source[1] == 4:
						combiner("right", i, j, grid2DArray[i][j].source[0])
	win = true
	for y in winArray:
		if y.destMatched == false:
			win = false
	
	if win:
		%ColorRect.won = true
		%AudioPlayer.playYippee()
		if (levelNumber > CurrentLevel.value):
			CurrentLevel.value =  levelNumber
		win_show.emit()
	else:
		%ColorRect.won = false
		win_hide.emit()


func rayDown(i,j,colour):
	i += 1
	if i < 5:
		if grid2DArray[i][j].prismSlot == null:
			grid2DArray[i][j].vert = [colour,1]
			grid2DArray[i][j].drawLine()
			rayDown(i,j,colour)
		elif grid2DArray[i][j].prismSlot.has_method("mirror"):
			mirror("down", i, j, colour)
		elif grid2DArray[i][j].prismSlot.has_method("splitter"):
			splitter("down", i, j, colour)
		elif grid2DArray[i][j].prismSlot.has_method("filter"):
			filter("down", i, j, colour)
		elif grid2DArray[i][j].prismSlot.has_method("combiner"):
			combiner("down", i, j, colour)

func rayLeft(i,j,colour):
	j -= 1
	if j > -1:
		if grid2DArray[i][j].prismSlot == null:
			grid2DArray[i][j].hor = [colour,1]
			grid2DArray[i][j].drawLine()
			rayLeft(i,j,colour)
		elif grid2DArray[i][j].prismSlot.has_method("mirror"):
			mirror("left", i, j, colour)
		elif grid2DArray[i][j].prismSlot.has_method("splitter"):
			splitter("left", i, j, colour)
		elif grid2DArray[i][j].prismSlot.has_method("filter"):
			filter("left", i, j, colour)
		elif grid2DArray[i][j].prismSlot.has_method("combiner"):
			combiner("left", i, j, colour)

func rayUp(i,j,colour):
	i -= 1
	if i > -1:
		if grid2DArray[i][j].prismSlot == null:
			grid2DArray[i][j].vert = [colour,2]
			grid2DArray[i][j].drawLine()
			rayUp(i,j,colour)
		elif grid2DArray[i][j].prismSlot.has_method("mirror"):
			mirror("up", i, j, colour)
		elif grid2DArray[i][j].prismSlot.has_method("splitter"):
			splitter("up", i, j, colour)
		elif grid2DArray[i][j].prismSlot.has_method("filter"):
			filter("up", i, j, colour)
		elif grid2DArray[i][j].prismSlot.has_method("combiner"):
			combiner("up", i, j, colour)

func rayRight(i,j,colour):
	j += 1
	if j < 5:
		if grid2DArray[i][j].prismSlot == null:
			grid2DArray[i][j].hor = [colour,2]
			grid2DArray[i][j].drawLine()
			rayRight(i,j,colour)
		elif grid2DArray[i][j].prismSlot.has_method("mirror"):
			mirror("right", i, j, colour)
		elif grid2DArray[i][j].prismSlot.has_method("splitter"):
			splitter("right", i, j, colour)
		elif grid2DArray[i][j].prismSlot.has_method("filter"):
			filter("right", i, j, colour)
		elif grid2DArray[i][j].prismSlot.has_method("combiner"):
			combiner("right", i, j, colour)

func mirror(direc, i, j, colour):
	if direc == "down":
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
	elif direc == "left":
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
	elif direc == "up":
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
	elif direc == "right":
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

func splitter(direc, i, j, colour):
	if direc == "down":
		if grid2DArray[i][j].prismSlot.direc == 1:
			if (colour == 2) or (colour == 3) or (colour == 4):
				grid2DArray[i][j].tr = [colour,1]
				grid2DArray[i][j].lt = [colour,2]
				grid2DArray[i][j].drawLine()
				rayRight(i,j,colour)
				rayLeft(i,j,colour)
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
	elif direc == "left":
		if grid2DArray[i][j].prismSlot.direc == 2:
			if (colour == 2) or (colour == 3) or (colour == 4):
				grid2DArray[i][j].tr = [colour,2]
				grid2DArray[i][j].rb = [colour,1]
				grid2DArray[i][j].drawLine()
				rayUp(i,j,colour)
				rayDown(i,j,colour)
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
	elif direc == "up":
		if grid2DArray[i][j].prismSlot.direc == 3:
			if (colour == 2) or (colour == 3) or (colour == 4):
				grid2DArray[i][j].rb = [colour,2]
				grid2DArray[i][j].bl = [colour,1]
				grid2DArray[i][j].drawLine()
				rayRight(i,j,colour)
				rayLeft(i,j,colour)
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
	elif direc == "right":
		if grid2DArray[i][j].prismSlot.direc == 4:
			if (colour == 2) or (colour == 3) or (colour == 4):
				grid2DArray[i][j].lt = [colour,1]
				grid2DArray[i][j].bl = [colour,2]
				grid2DArray[i][j].drawLine()
				rayUp(i,j,colour)
				rayDown(i,j,colour)
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

func filter(direc, i, j, colour):
	var filter = grid2DArray[i][j].prismSlot.filterColour
	if filter != colour:
		if colour == 5:
			if filter == 2:
				colour = 3
			elif filter == 3:
				colour = 2
		elif colour == 6:
			if filter == 3:
				colour = 4
			elif filter == 4:
				colour = 3
		elif colour == 7:
			if filter == 2:
				colour = 4
			elif filter == 4:
				colour = 2

		if direc == "down":
			grid2DArray[i][j].vert = [colour,1]
			grid2DArray[i][j].drawLine()
			rayDown(i,j,colour)
		elif direc == "left":
			grid2DArray[i][j].hor = [colour,1]
			grid2DArray[i][j].drawLine()
			rayLeft(i,j,colour)
		elif direc == "up":
			grid2DArray[i][j].vert = [colour,2]
			grid2DArray[i][j].drawLine()
			rayUp(i,j,colour)
		elif direc == "right":
			grid2DArray[i][j].hor = [colour,2]
			grid2DArray[i][j].drawLine()
			rayRight(i,j,colour)

func combiner(direc, i, j, colour):
	if direc == "down":
		if grid2DArray[i][j].prismSlot.direc == 2:
			grid2DArray[i][j].tr = [colour,1]
			grid2DArray[i][j].prismSlot.ray2 = colour
		elif grid2DArray[i][j].prismSlot.direc == 4:
			grid2DArray[i][j].lt = [colour,2]
			grid2DArray[i][j].prismSlot.ray1 = colour
	elif direc == "left":
		if grid2DArray[i][j].prismSlot.direc == 1:
			grid2DArray[i][j].tr = [colour,2]
			grid2DArray[i][j].prismSlot.ray1 = colour
		elif grid2DArray[i][j].prismSlot.direc == 3:
			grid2DArray[i][j].rb = [colour,1]
			grid2DArray[i][j].prismSlot.ray2 = colour
	elif direc == "up":
		if grid2DArray[i][j].prismSlot.direc == 2:
			grid2DArray[i][j].rb = [colour,2]
			grid2DArray[i][j].prismSlot.ray1 = colour
		elif grid2DArray[i][j].prismSlot.direc == 4:
			grid2DArray[i][j].bl = [colour,1]
			grid2DArray[i][j].prismSlot.ray2 = colour
	elif direc == "right":
		if grid2DArray[i][j].prismSlot.direc == 1:
			grid2DArray[i][j].lt = [colour,2]
			grid2DArray[i][j].prismSlot.ray2 = colour
		elif grid2DArray[i][j].prismSlot.direc == 3:
			grid2DArray[i][j].bl = [colour,1]
			grid2DArray[i][j].prismSlot.ray1 = colour
	if grid2DArray[i][j].prismSlot.ray1 + grid2DArray[i][j].prismSlot.ray2 > 1:
		var newColour = evalRays(grid2DArray[i][j].prismSlot.ray1, grid2DArray[i][j].prismSlot.ray2)
		if newColour != 0:
			if grid2DArray[i][j].prismSlot.direc == 1:
				rayUp(i,j,newColour)
			elif grid2DArray[i][j].prismSlot.direc == 2:
				rayRight(i,j,newColour)
			elif grid2DArray[i][j].prismSlot.direc == 3:
				rayDown(i,j,newColour)
			elif grid2DArray[i][j].prismSlot.direc == 4:
				rayLeft(i,j,newColour)
	grid2DArray[i][j].drawLine()

func evalRays(ray1, ray2):
	if (ray1 != 0) and (ray2 != 0):
		if (ray1 == 2 and ray2 == 3) or (ray2 == 2 and ray1 == 3):
			return 5
		elif (ray1 == 2 and ray2 == 4) or (ray1 == 4 and ray2 == 2):
			return 7
		elif (ray1 == 3 and ray2 == 4) or (ray1 == 4 and ray2 == 3):
			return 6
	if ray1 == ray2:
		return ray1
	return 0
