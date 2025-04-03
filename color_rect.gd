extends ColorRect

var won = true
var time_passed = 0.0

func _process(delta):
	if won == true:
		time_passed += delta/2
		var r = sin(time_passed) * 0.5 + 0.5
		var g = sin(time_passed + 2.094) * 0.5 + 0.5  # Offset by 2π/3
		var b = sin(time_passed + 4.188) * 0.5 + 0.5  # Offset by 4π/3
		self.color = Color(r*0.8, g*0.8, b*0.8)
	else:
		self.color = Color("Dark Gray")
