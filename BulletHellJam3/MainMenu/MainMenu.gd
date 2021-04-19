extends Control

func _on_PlayButton_pressed() -> void:
	$AnimationPlayer.play("SceneTransition")


func _on_QuitButton_pressed() -> void:
	get_tree().quit()


func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	if anim_name == "SceneTransition":
		get_tree().change_scene("res://World/World.tscn")