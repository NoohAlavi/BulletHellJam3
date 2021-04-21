extends Sprite

func set_time(time):
	if time < 1:
		texture = load("res://Timer/Timer_1.png")
	if time < 2.5:
		texture = load("res://Timer/Timer_2.png")
	if time < 5:
		texture = load("res://Timer/Timer_3.png")
	if time < 7.5:
		texture = load("res://Timer/Timer_4.png")
	if time < 10:
		texture = load("res://Timer/Timer_5.png")
