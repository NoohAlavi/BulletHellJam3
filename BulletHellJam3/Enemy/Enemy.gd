extends KinematicBody2D

export var bullet_scene: PackedScene
export var max_health: float = 10

onready var health = max_health
onready var player = get_parent().get_parent().get_node("Player")

func damage(dmg: float):
	health -= dmg
	if health <= 0:
		queue_free()

func _on_ShootTimer_timeout() -> void:
	var bullet = bullet_scene.instance()
