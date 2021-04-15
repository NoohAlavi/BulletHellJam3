extends Area2D
class_name Bullet

export var speed: float
export var direction: Vector2

func _physics_process(delta: float) -> void:
	position += direction * speed * delta


func _on_Timer_timeout() -> void:
	queue_free()
