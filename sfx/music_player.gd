extends AudioStreamPlayer2D

var jazz = preload("res://sfx/jazz.mp3")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if CurrentLevel.mutedAudio == true:
		if self.playing == true:
			CurrentLevel.musicPos = self.get_playback_position()
			self.playing = false
	else:
		if self.playing == false:
			playJazz()
		


func playJazz():
	self.stream = jazz
	self.play(CurrentLevel.musicPos)

func _on_finished() -> void:
	self.play()
