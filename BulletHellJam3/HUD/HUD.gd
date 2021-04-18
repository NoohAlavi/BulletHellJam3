extends Control

onready var world = get_parent().get_parent()

onready var player = world.get_node("Player")
onready var timer: Timer = world.get_node("EnemySpawnTimer")

onready var debug_info = $DebugInfo/VBoxContainer
onready var hud = $HUD

func _process(delta: float) -> void:
	update_hud()
	update_debug()

func update_debug():
	debug_info.get_node("FPSLabel").text = "FPS: " + str(Engine.get_frames_per_second())
	debug_info.get_node("MemUsage").text = "Memory Usage: " + str(OS.get_static_memory_usage()) + "B"
	debug_info.get_node("WindowSize").text = "Window Size: " + str(OS.window_size)
	debug_info.get_node("BulletCountLabel").text = "Spawned Bullets: " + str(len(get_parent().get_parent().get_node("BulletHolder").get_children()))
	debug_info.get_node("EnemyCountLabel").text = "Spawned Enemies: " + str(len(get_parent().get_parent().get_node("EnemyHolder").get_children()))
	debug_info.get_node("PlayerHealthLabel").text = "Player Health: " + str(player.health) + " / " + str(player.max_health)
	debug_info.get_node("NextSpawnTime").text = "Time Before Next Spawn: " + str(timer.time_left)

	if len(Input.get_connected_joypads()) > 0:
		debug_info.get_node("IsControllerConnected").text = "Controller Connected: True"
	else:
		debug_info.get_node("IsControllerConnected").text = "Controller Connected: False"
	
	if Input.is_action_just_pressed("toggle_debug"):
		$DebugInfo.visible = !$DebugInfo.visible

func update_hud():
	hud.get_node("HealthLabel").text = "HP: " + str(round((player.health / player.max_health) * 100)) + "%"
	hud.get_node("ScoreLabel").text = "Score: " + str(player.score)
	var is_invincible = "Yes" if player.is_invincible else "No"
	hud.get_node("InvincibleLabel").text = "Invincible: " + str(is_invincible)
	hud.get_node("InvincibleLabel").modulate = Color(0, 255, 0) if player.is_invincible else Color(255, 0, 0)
