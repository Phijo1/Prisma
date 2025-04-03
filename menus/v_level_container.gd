extends VBoxContainer

@onready var v_level_container = $"."
var current_level = 0

func _ready():
	%MusicPlayer.playJazz()
	for i in range(20):
		var button = Button.new()
		button.text = "Level %d" %(i + 1)
		button.disabled = i > CurrentLevel.value
		button.pressed.connect(_on_level_button_pressed.bind("res://levels/level%d.tscn" %(i+1)))
		v_level_container.add_child(button)

func _on_level_button_pressed(scene: String):
	CurrentLevel.musicPos = %MusicPlayer.get_playback_position()
	get_tree().change_scene_to_file(scene)

func _on_level_complete():
	current_level += 1
	var next_level_button = v_level_container.get_child(current_level)
	next_level_button.disabled = false
