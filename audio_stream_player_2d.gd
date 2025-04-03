extends AudioStreamPlayer2D

var yippee = preload("res://sfx/yippee.mp3")
var pickup = preload("res://sfx/pickup.wav")
var putDown = preload("res://sfx/putDown.mp3")
var celebrate = preload("res://sfx/new_song.mp3")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !self.is_playing():
		if self.pitch_scale != 1.0:
			self.pitch_scale = 1.0


func playYippee():
	if CurrentLevel.mutedAudio == false:
		self.stream = yippee
		self.play()

func playCelebrate():
	if CurrentLevel.mutedAudio == false:
		self.stream = celebrate
		self.play()

func playPickup():
	if CurrentLevel.mutedAudio == false:
		self.stream = pickup
		self.pitch_scale = self.pitch_scale + randf_range(-0.1,0.1)
		self.play()

func playPutDown():
	if CurrentLevel.mutedAudio == false:
		self.stream = putDown
		self.pitch_scale = self.pitch_scale + randf_range(-0.1,0.0)
		self.play()
