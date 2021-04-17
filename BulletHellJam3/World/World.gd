extends Node2D

export var enemy_scene: PackedScene
export var enemies_to_spawn = 5

var screen_size

func _ready() -> void:
	randomize()
	screen_size = get_viewport_rect().size

func _on_EnemySpawnTimer_timeout() -> void:
	for i in range(enemies_to_spawn):
		var enemy = enemy_scene.instance()
		enemy.position = Vector2(
			rand_range(0, screen_size.x),
			rand_range(0, screen_size.y)
		)
		$EnemyHolder.add_child(enemy)
