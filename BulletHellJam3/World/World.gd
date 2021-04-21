extends Node2D

export var enemy_scene: PackedScene
export var min_enemies_to_spawn: int
export var max_enemies_to_spawn: int
export var events: Array = [
	
]
onready var player = $Player

var screen_size
onready var spawn_timer: Timer = $EnemySpawnTimer

func _ready() -> void:
	randomize()
	screen_size = get_viewport_rect().size
	spawn_enemies()

func _on_EnemySpawnTimer_timeout() -> void:
	spawn_enemies()
	
func _process(delta: float) -> void:
	if $EnemyHolder.get_child_count() == 0:
		spawn_enemies()
		spawn_timer.start()
	$HUDLayer/HUD/Timer.set_time($TenSecondTimer.time_left)

func spawn_enemies():
	var enemies_to_spawn = round(rand_range(min_enemies_to_spawn, max_enemies_to_spawn))
	for i in range(enemies_to_spawn):
		var enemy = enemy_scene.instance()
		enemy.position = Vector2(
			rand_range(0, screen_size.x),
			rand_range(0, screen_size.y)
		)
		$EnemyHolder.add_child(enemy)
		
func add_bullet(bullet):
	$BulletHolder.add_child(bullet)

func _on_TenSecondTimer_timeout() -> void:
	var event = events[round(rand_range(0, len(events) - 1))]
	print(event)
	
	var event_label = $HUDLayer/HUD.event_label
	event_label.show()
	event_label.text = "Event: " + event
	$EventNoise.play()
	
	if event == "Blindness":
		$HUDLayer/HUD/AnimationPlayer.play("Blindness")
	elif event == "Invincibility":
		player.make_invincible()
	elif event == "Score Multiplier":
		player.multiply_score()
	elif event == "Spawn Enemies":
		spawn_enemies()
	elif event == "Destroy All Bullets":
		for bullet in $BulletHolder.get_children():
			bullet.queue_free()
	elif event == "Heal":
		if player.health < player.max_health:
			player.health += 1
	else:
		print("Error! Invalid Event " + event)
		
	yield(get_tree().create_timer(2), "timeout")
	event_label.hide()
