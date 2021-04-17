extends Control

onready var world = get_parent().get_parent()

onready var player = world.get_node("Player")
onready var timer: Timer = world.get_node("EnemySpawnTimer")

func _process(delta: float) -> void:
	$Info/VBoxContainer/FPSLabel.text = "FPS: " + str(Engine.get_frames_per_second())
	$Info/VBoxContainer/MemUsage.text = "Memory Usage: " + str(OS.get_static_memory_usage()) + "B"
	$Info/VBoxContainer/WindowSize.text = "Window Size: " + str(OS.window_size)
	$Info/VBoxContainer/BulletCountLabel.text = "Spawned Bullets: " + str(len(get_parent().get_parent().get_node("BulletHolder").get_children()))
	$Info/VBoxContainer/EnemyCountLabel.text = "Spawned Enemies: " + str(len(get_parent().get_parent().get_node("EnemyHolder").get_children()))
	$Info/VBoxContainer/PlayerHealthLabel.text = "Player Health: " + str(player.health) + " / " + str(player.max_health)
	$Info/VBoxContainer/NextSpawnTime.text = "Time Before Next Spawn: " + str(timer.time_left)
	
	$HealthLabel.text = "HP: " + str((player.health / player.max_health) * 100) + "%"
	
	if len(Input.get_connected_joypads()) > 0:
		$Info/VBoxContainer/IsControllerConnected.text = "Controller Connected: True"
	else:
		$Info/VBoxContainer/IsControllerConnected.text = "Controller Connected: False"
	
	if Input.is_action_just_pressed("toggle_debug"):
		$Info.visible = !$Info.visible
