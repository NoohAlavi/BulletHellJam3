extends Control

export var target_scene = "res://World/World.tscn"

func _on_PlayButton_pressed() -> void:
	$AnimationPlayer.play("SceneTransition")
	target_scene = "res://World/World.tscn"

func _on_QuitButton_pressed() -> void:
	get_tree().quit()

func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	if anim_name == "SceneTransition":
		get_tree().change_scene(target_scene)

func _on_ControlsButton_pressed() -> void:
	$AnimationPlayer.play("SceneTransition")
	target_scene = "res://Controls/Controls.tscn"

func _on_CreditsButton_pressed() -> void:
	$AnimationPlayer.play("SceneTransition")
	target_scene = "res://Credits/Credits.tscn"
