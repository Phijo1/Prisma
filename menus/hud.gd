extends CanvasLayer

func _ready():
	$NextLevelButton.visible = false

func _on_home_button_pressed() -> void:
	get_tree().change_scene_to_file("res://menus/main_menu.tscn")

func _on_next_level_button_pressed() -> void:
	get_tree().change_scene_to_file("res://levels/level%d.tscn" %CurrentLevel.value)

func _on_level_win_hide() -> void:
	$NextLevelButton.visible = false

func _on_level_win_show() -> void:
	$NextLevelButton.visible = true
