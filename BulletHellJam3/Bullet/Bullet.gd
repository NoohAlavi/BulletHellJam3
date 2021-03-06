extends Area2D
class_name Bullet

export var speed: float
export var direction: Vector2
export var damage: float = 1
export var is_enemy_bullet: bool = false

var anim = "RedBullet"
onready var screen_size = get_viewport_rect().size

func _physics_process(delta: float) -> void:
	position += direction * speed * delta

func _process(delta: float) -> void:
	$Sprite.animation = anim
	
	if position.x > screen_size.x or position.y > screen_size.y or position.y < 0 or position.x < 0:
		queue_free()

func _on_Timer_timeout() -> void:
	queue_free()

func _on_Bullet_body_entered(body: Node) -> void:
	if body.get_parent().name == "EnemyHolder" and not is_enemy_bullet:
		body.damage(damage)
		queue_free()
	if body.name == "Player" and is_enemy_bullet:
		body.damage(damage)
		queue_free()
