extends Area2D

@onready var gridChecker = %GridChecker

var pickedUp = false
var mouseOver = false
var lastLocation: Control
var ray1 = 0
var ray2 = 0
@export var direc = 1
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	lastLocation = get_parent()
	lastLocation.prismSlot = self
	rotation_degrees = 360/4 * direc

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if pickedUp == true:
		global_position = get_global_mouse_position()


func _input(event):
	if event is InputEventMouseButton:
		if event.pressed == true:
			if (pickedUp == false) and (mouseOver == true):
				pickedUp = true
		if event.pressed == false:
			if (pickedUp == true) and (mouseOver == true):
				pickedUp = false
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
	if (Input.is_action_just_pressed("r_left")) and pickedUp == true:
		direc -= 1
		if direc == 0:
			direc = 4
		rotation_degrees = 360/4 * direc
	if (Input.is_action_just_pressed("r_right")) and pickedUp == true:
		direc += 1
		if direc == 5:
			direc = 1
		rotation_degrees = 360/4 * direc


func _on_mouse_entered() -> void:
	mouseOver = true


func _on_mouse_exited() -> void:
	mouseOver = false


func combiner():
	print("TODO")
