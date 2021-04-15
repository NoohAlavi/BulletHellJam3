extends KinematicBody2D


export var velocity := Vector2.ZERO
export var movement_speed = 200

export var bullet_scene: PackedScene

var screen_size

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

func shoot():
	var bullet = bullet_scene.instance()
	bullet.position = position
	get_parent().get_node("BulletHolder").add_child(bullet)
