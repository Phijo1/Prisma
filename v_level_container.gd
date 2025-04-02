extends VBoxContainer

@onready var v_level_container = $"."

func _ready():
	for i in range(20):
		var button = Button.new()
		button.text = "Level %d" %(i + 1)
		button.disabled = i > 0
		button.pressed.connect(_on_level_button_pressed.bind("res://levels/level%d.tscn" %(i+1)))
		v_level_container.add_child(button)

func _on_level_button_pressed(scene: String):
	get_tree().change_scene_to_file(scene)

func _on_level_complete(level_number: int):
	var next_level_button = v_level_container.get_child(level_number)
	next_level_button.disabled = false
