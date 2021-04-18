extends KinematicBody2D

export var bullet_scene: PackedScene
export var max_health: float = 10
export var burst_bullet_count = 10
export var follow_speed: float

onready var world = get_parent().get_parent()
onready var health = max_health
onready var player = world.get_node("Player")

func _ready():
	randomize()
	shoot()

func damage(dmg: float):
	health -= dmg
	$AnimationPlayer.play("Hurt")
	if health <= 0:
		player.score += 5
		shoot_burst("GreenBullet")
		queue_free()
		
func follow():
	var velocity = position.direction_to(player.position) * follow_speed
	velocity = move_and_slide(velocity)

func _on_ShootTimer_timeout() -> void:
	shoot()

func _on_BurstTimer_timeout() -> void:
	shoot_burst("PurpleBullet")

func shoot():
	if randf() >= 0.5:
		return
	var bullet = bullet_scene.instance()
	bullet.direction = position.direction_to(player.position)
	bullet.position = position
	bullet.is_enemy_bullet = true
	bullet.speed = 250
	bullet.anim = "BlueBullet"
	world.add_bullet(bullet)

func shoot_burst(col):
	
	var angle = 360 / burst_bullet_count
	
	for i in range(burst_bullet_count):
		
		var dir = Vector2(0, 1).rotated(deg2rad(angle * i))
		
		var bullet = bullet_scene.instance()
		bullet.position = position
		bullet.is_enemy_bullet = true
		bullet.anim = col
		bullet.direction = dir
		bullet.speed = 100
		world.add_bullet(bullet)

func _physics_process(delta: float) -> void:
	follow()
