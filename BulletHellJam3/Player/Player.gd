extends KinematicBody2D

export var velocity := Vector2.ZERO
export var movement_speed = 200
export var max_health = 100

export var bullet_scene: PackedScene

var screen_size
var score = 0
onready var health = max_health

func _ready() -> void:
	screen_size = get_viewport_rect().size

func _physics_process(delta: float) -> void:
	handle_input()
	
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)
	
func handle_input():
	var input_x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	var input_y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	velocity = Vector2(input_x, input_y).normalized() * movement_speed
	
	velocity = move_and_slide(velocity)
	
	if (Input.is_action_pressed("shoot")):
		shoot()
		
func _process(delta: float) -> void:
	$Sprite.look_at(get_global_mouse_position())

func get_controller_dir() -> Vector2:
	return Vector2(
		Input.get_action_strength("shoot_right") - Input.get_action_strength("shoot_left"),
		Input.get_action_strength("shoot_down") - Input.get_action_strength("shoot_up")
	)

func shoot():
	var bullet: Bullet = bullet_scene.instance()
	var dir
	var c_dir = get_controller_dir()
	
	if (len(Input.get_connected_joypads()) > 0 and c_dir > Vector2.ZERO):
		dir = c_dir
	else:
		dir = position.direction_to($Sprite.get_global_mouse_position())
	
	bullet.position = position
	bullet.direction = dir
	bullet.speed = 500
	bullet.is_enemy_bullet = false
	bullet.anim = "RedBullet"
	get_parent().add_bullet(bullet)
	
func damage(dmg):
	health -= dmg
	$AnimationPlayer.play("Hurt")
	if health <= 0:
		get_tree().reload_current_scene()
