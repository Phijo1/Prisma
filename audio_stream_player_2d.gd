extends AudioStreamPlayer2D

var yippee = preload("res://sfx/yippee.mp3")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func playYippee():
	if CurrentLevel.mutedAudio == false:
		self.stream = yippee
		self.play()
