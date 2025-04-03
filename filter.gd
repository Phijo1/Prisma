extends Area2D

@onready var gridChecker = %GridChecker

var pickedUp = false
var mouseOver = false
var lastLocation: Control
var wiggle = 0.0
var goingUp = true
var spriteRotate = 0.0
@export var direc = 1
@export var filterColour = 2

var colourDict = {0:"Black", 1:"White", 2:"Red", 3:"Blue", 4:"Yellow", 5:"Purple", 6:"Green", 7:"Orange"}
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	lastLocation = get_parent()
	lastLocation.prismSlot = self
	modulate = Color(colourDict[filterColour])
	rotation_degrees = 360/4 * direc

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if pickedUp == true:
		global_position = get_global_mouse_position()
		%Sprite2D.rotate(wiggle)
		if goingUp == true:
			wiggle += 0.00001
			if wiggle > 0.0007:
				goingUp = false
		else:
			wiggle -= 0.00001
			if wiggle < -0.0007:
				goingUp = true


func _input(event):
	if event is InputEventMouseButton and event.button_index == 1:
		if event.pressed == true:
			if (pickedUp == false) and (mouseOver == true):
				spriteRotate = %Sprite2D.rotation
				pickedUp = true
				%AudioPlayer.playPickup()
		if event.pressed == false:
			if (pickedUp == true) and (mouseOver == true):
				pickedUp = false
				%Sprite2D.rotation = spriteRotate
				%AudioPlayer.playPutDown()
				var areas = gridChecker.get_overlapping_areas()
				if len(areas) > 1:
					if areas[1].get_parent().has_method("empty_grid"):
						if areas[1].get_parent().prismSlot == null:
							lastLocation.prismSlot = null
							get_parent().remove_child(self)
							areas[1].get_parent().get_parent().add_child(self)
							lastLocation = areas[1].get_parent()
							lastLocation.prismSlot = self
							global_position = lastLocation.global_position
						else:
							global_position = lastLocation.global_position
					else:
						global_position = lastLocation.global_position
				else:
					global_position = lastLocation.global_position
				get_node("/root/Level").updateLight()
	if (Input.is_action_just_pressed("r_left")) and mouseOver == true:
		if pickedUp == true:
			direc -= 1
			if direc == 0:
				direc = 4
			rotation_degrees = 360/4 * direc
			return
		elif pickedUp == false and checkUnder() == false:
			direc -= 1
			if direc == 0:
				direc = 4
			rotation_degrees = 360/4 * direc
			get_node("/root/Level").updateLight()
			return
	if (Input.is_action_just_pressed("r_right")) and mouseOver == true:
		if pickedUp == true:
			direc += 1
			if direc == 5:
				direc = 1
			rotation_degrees = 360/4 * direc
			return
		elif pickedUp == false and checkUnder() == false:
			direc += 1
			if direc == 5:
				direc = 1
			rotation_degrees = 360/4 * direc
			get_node("/root/Level").updateLight()
			return


func _on_mouse_entered() -> void:
	mouseOver = true
	self.modulate = Color(colourDict[filterColour]).darkened(0.2)


func _on_mouse_exited() -> void:
	mouseOver = false
	self.modulate = Color(colourDict[filterColour])


func filter():
	print("TODO")

func checkUnder():
	var overlay = gridChecker.get_overlapping_areas()
	for i in overlay:
		if i != self:
			if i.has_method("checkUnder"):
				return true
	return false
