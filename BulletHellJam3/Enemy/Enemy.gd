extends KinematicBody2D

export var bullet_scene: PackedScene
export var max_health: float = 10

onready var world = get_parent().get_parent()
onready var health = max_health
onready var player = world.get_node("Player")

func _ready():
	#shoot()
	pass

func damage(dmg: float):
	health -= dmg
	$AnimationPlayer.play("Hurt")
	if health <= 0:
		player.score += 5
		queue_free()

func _on_ShootTimer_timeout() -> void:
	shoot()

func _on_BurstTimer_timeout() -> void:
	shoot_burst()

func shoot():
	var bullet = bullet_scene.instance()
	bullet.direction = position.direction_to(player.position)
	bullet.position = position
	bullet.is_enemy_bullet = true
	bullet.speed = 250
	bullet.anim = "BlueBullet"
	world.add_bullet(bullet)

func shoot_burst():
	for i in range(10):
		var bullet = bullet_scene.instance()
		bullet.position = position
		bullet.is_enemy_bullet = true
		bullet.anim = "PurpleBullet"
		world.add_bullet(bullet)
