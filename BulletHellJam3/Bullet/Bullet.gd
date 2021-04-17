extends Area2D
class_name Bullet

export var speed: float
export var direction: Vector2
export var damage: float = 1

var anim = "FireBullet"

func _physics_process(delta: float) -> void:
	position += direction * speed * delta

func _process(delta: float) -> void:
	$Sprite.animation = anim

func _on_Timer_timeout() -> void:
	queue_free()

func _on_Bullet_body_entered(body: Node) -> void:
	if body.get_parent().name == "EnemyHolder":
		body.damage(damage)
		queue_free()
