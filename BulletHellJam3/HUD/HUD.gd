extends Control

func _process(delta: float) -> void:
	$Info/VBoxContainer/FPSLabel.text = "FPS: " + str(Engine.get_frames_per_second())
	$Info/VBoxContainer/BulletCountLabel.text = "Spawned Bullets: " + str(len(get_parent().get_parent().get_node("BulletHolder").get_children()))
	
	if Input.is_action_just_pressed("toggle_debug"):
		$Info.visible = !$Info.visible
