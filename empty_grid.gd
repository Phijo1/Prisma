extends Control

@onready var sourceU = %SourceU
@onready var sourceR = %SourceR
@onready var sourceD = %SourceD
@onready var sourceL = %SourceL
var lineObject = preload("res://light_line.tscn")

var prismSlot: Area2D
@export var source = [0,0]
@export var dest = [0,0]

var destSource: Sprite2D

var destMatched = false

var vert = [0,0]
var hor = [0,0]
var tr = [0,0]
var rb = [0,0]
var bl = [0,0]
var lt = [0,0]

var colourDict = {0:"Black", 1:"White", 2:"Red", 3:"Blue", 4:"Yellow", 5:"Purple", 6:"Green", 7:"Orange"}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if source[1] == 1:
		sourceU.visible = true
	elif source[1] == 2:
		sourceR.visible = true
	elif source[1] == 3:
		sourceD.visible = true
	elif source[1] == 4:
		sourceL.visible = true

	if dest[1] == 1:
		sourceU.visible = true
		sourceU.modulate = Color(colourDict[dest[0]])
		destSource = sourceU
	elif dest[1] == 2:
		sourceR.visible = true
		sourceR.modulate = Color(colourDict[dest[0]])
		destSource = sourceR
	elif dest[1] == 3:
		sourceD.visible = true
		sourceD.modulate = Color(colourDict[dest[0]])
		destSource = sourceD
	elif dest[1] == 4:
		sourceL.visible = true
		sourceL.modulate = Color(colourDict[dest[0]])
		destSource = sourceL
	
	for i in get_children():
		if i.has_method("block"):
			prismSlot = i

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func empty_grid():
	print("lmao")

func drawLine():
	var children = get_children()
	for i in children:
		if i.has_method("line_object"):
			i.queue_free()
	if vert[1] != 0:
		var newLine = lineObject.instantiate()
		newLine.points[0] = Vector2(0,-64)
		newLine.points[1] = Vector2(0,64)
		newLine.default_color = Color(colourDict[vert[0]])
		add_child(newLine)
		if (dest[1] == 1) or (dest[1] == 3):
			if vert[0] == dest[0]:
				destMatched = true
	if hor[1] != 0:
		var newLine2 = lineObject.instantiate()
		newLine2.points[0] = Vector2(-64,0)
		newLine2.points[1] = Vector2(64,0)
		newLine2.default_color = Color(colourDict[hor[0]])
		add_child(newLine2)
		if (dest[1] == 2) or (dest[1] == 4):
			if hor[0] == dest[0]:
				destMatched = true
	if tr[1] != 0:
		var newLine3 = lineObject.instantiate()
		newLine3.points[0] = Vector2(0,-64)
		newLine3.points[1] = Vector2(0,0)
		newLine3.add_point(Vector2(64,0))
		newLine3.default_color = Color(colourDict[tr[0]])
		add_child(newLine3)
		if (dest[1] == 1) or (dest[1] == 2):
			if tr[0] == dest[0]:
				destMatched = true
	if lt[1] != 0:
		var newLine4 = lineObject.instantiate()
		newLine4.points[0] = Vector2(0,-64)
		newLine4.points[1] = Vector2(0,0)
		newLine4.add_point(Vector2(-64,0))
		newLine4.default_color = Color(colourDict[lt[0]])
		add_child(newLine4)
		if (dest[1] == 4) or (dest[1] == 1):
			if lt[0] == dest[0]:
				destMatched = true
	if rb[1] != 0:
		var newLine5 = lineObject.instantiate()
		newLine5.points[0] = Vector2(0,64)
		newLine5.points[1] = Vector2(0,0)
		newLine5.add_point(Vector2(64,0))
		newLine5.default_color = Color(colourDict[rb[0]])
		add_child(newLine5)
		if (dest[1] == 2) or (dest[1] == 3):
			if rb[0] == dest[0]:
				destMatched = true
	if bl[1] != 0:
		var newLine6 = lineObject.instantiate()
		newLine6.points[0] = Vector2(0,64)
		newLine6.points[1] = Vector2(0,0)
		newLine6.add_point(Vector2(-64,0))
		newLine6.default_color = Color(colourDict[bl[0]])
		add_child(newLine6)
		if (dest[1] == 3) or (dest[1] == 4):
			if bl[0] == dest[0]:
				destMatched = true
	if destMatched == true:
		destSource.modulate = Color("Black")
		
func clearLines():
	if destMatched == true:
		destMatched = false
		destSource.modulate = Color(colourDict[dest[0]])
	var children = get_children()
	for i in children:
		if i.has_method("line_object"):
			i.queue_free()
	vert = [0,0]
	hor = [0,0]
	tr = [0,0]
	rb = [0,0]
	bl = [0,0]
	lt = [0,0]
