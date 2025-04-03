extends CanvasLayer

func _ready():
	$NextLevelButton.visible = false
	$MuteAudio.button_pressed = CurrentLevel.mutedAudio

func _on_home_button_pressed() -> void:
	CurrentLevel.musicPos = %MusicPlayer.get_playback_position()
	get_tree().change_scene_to_file("res://menus/main_menu.tscn")

func _on_next_level_button_pressed() -> void:
	CurrentLevel.musicPos = %MusicPlayer.get_playback_position()
	get_tree().change_scene_to_file("res://levels/level%d.tscn" %(CurrentLevel.value + 1))

func _on_mute_audio_toggled(toggled_on: bool) -> void:
	CurrentLevel.mutedAudio = toggled_on


func _on_level_win_hide() -> void:
	$NextLevelButton.visible = false

func _on_level_win_show() -> void:
	$NextLevelButton.visible = true
