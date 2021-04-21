extends Control

func _on_BackButton_pressed() -> void:
	get_tree().change_scene("res://MainMenu/MainMenu.tscn")

func _on_Nooh_pressed() -> void:
		OS.shell_open("https://twitch.tv/opsci");
		OS.shell_open("https://noohalavi.itch.io");
		OS.shell_open("https://www.youtube.com/channel/UC2W0dJwYSOHm4Rn1p17P6qg");
		OS.shell_open("https://www.github.com/NoohAlavi");

func _on_Nishy_pressed() -> void:
	OS.shell_open("https://soundcloud.com/prodnishy");
	OS.shell_open("https://twitch.tv/prodnishy");
	OS.shell_open("https://www.youtube.com/channel/UCATENuBKkVByd3tiJsCYw1A");
