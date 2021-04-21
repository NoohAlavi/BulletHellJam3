extends KinematicBody2D

export var bullet_scene: PackedScene
export var max_health: float = 10
export var burst_bullet_count = 10
export var follow_speed: float
export var spawned: bool = false

onready var world = get_parent().get_parent()
onready var health = max_health
onready var player = world.get_node("Player")
onready var sprite = $Sprite
onready var particles = $SpawnParticles

func _ready():
	randomize()
	sprite.hide()
	pick_type()
	particles.show()
	$CollisionShape2D.set_deferred("disabled", true)
	yield(get_tree().create_timer(2), "timeout")
	sprite.show()
	particles.hide()
	$CollisionShape2D.set_deferred("disabled", false)
	spawned = true
	shoot()

func pick_type():
	var rand = round(rand_range(1, 3))
	if rand == 1:
		sprite.animation = "Red"
		particles.color = Color(255, 0, 0)
		max_health = 40
	elif rand == 2:
		sprite.animation = "Pink"
		particles.color = Color("f500ee")
		max_health = 20
	elif rand == 3:
		sprite.animation = "Green"
		particles.color = Color(0, 255, 0)
		max_health = 10
	else:
		print("Error: Unknown type number " + str(rand))

func damage(dmg: float):
	if not spawned:
		return
	health -= dmg
	$AnimationPlayer.play("Hurt")
	if health <= 0:
		player.score += 10 * player.score_multiplier
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
	if not spawned:
		return
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
	
	if not spawned:
		return
	
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
	if not spawned:
		return
	follow()
