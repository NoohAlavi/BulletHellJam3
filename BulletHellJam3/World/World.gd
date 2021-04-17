extends Node2D

export var enemy_scene: PackedScene
export var enemies_to_spawn = 5

var screen_size

func _ready() -> void:
	randomize()
	screen_size = get_viewport_rect().size
	spawn_enemies()

func _on_EnemySpawnTimer_timeout() -> void:
	spawn_enemies()

func spawn_enemies():
	for i in range(enemies_to_spawn):
		var enemy = enemy_scene.instance()
		enemy.position = Vector2(
			rand_range(0, screen_size.x),
			rand_range(0, screen_size.y)
		)
		$EnemyHolder.add_child(enemy)
		
func add_bullet(bullet):
	$BulletHolder.add_child(bullet)
