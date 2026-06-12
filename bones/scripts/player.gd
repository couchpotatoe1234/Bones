extends CharacterBody2D

signal lives_changed(new_lives_count: int)
const SPEED = 150.0
const JUMP_VELOCITY = -300.0
@export var max_lives : int = 5
var current_lives : int
var shake_intensity : float = 0.0
var shake_fade : float = 5.0
var controls_allowed : bool = true
var is_turning : bool = false
var is_attacking : bool = false

@onready var camera = $Camera2D
@export var respawn_position : Vector2

func _ready() -> void:
	respawn_position = global_position
	current_lives = max_lives

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	if controls_allowed:
		if Input.is_action_just_pressed("attack") and not is_attacking:
			is_attacking = true
			$AnimatedSprite2D.play("attack")
			get_tree().create_timer(0.25).timeout.connect(func(): is_attacking = false)
		if Input.is_action_just_pressed("jump") and is_on_floor():
			velocity.y = JUMP_VELOCITY
		var direction := Input.get_axis("move_left", "move_right")
		if direction:
			velocity.x = direction * SPEED
			if ((direction < 0 and not $AnimatedSprite2D.flip_h) or (direction > 0 and $AnimatedSprite2D.flip_h)) and not is_turning:
				is_turning = true
				if not is_attacking:
					$AnimatedSprite2D.play("turn")
				get_tree().create_timer(0.07).timeout.connect(func(): is_turning = false)
			if not is_turning and is_on_floor() and not is_attacking:
				$AnimatedSprite2D.play("run")
			$AnimatedSprite2D.flip_h = (direction < 0)
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			if is_on_floor() and not is_turning and not is_attacking:
				$AnimatedSprite2D.play("idle")
		if not is_on_floor() and velocity.y > 0 and not is_attacking:
			$AnimatedSprite2D.play("fall")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED * 2)
	move_and_slide()

func _process(delta: float) -> void:
	if shake_intensity > 0:
		shake_intensity = move_toward(shake_intensity, 0, shake_fade * delta)
		camera.offset = Vector2(randf_range(-shake_intensity, shake_intensity), randf_range(-shake_intensity, shake_intensity))
	else:
		camera.offset = Vector2.ZERO

func screen_shake(intensity: float, fade_speed: float = 15.0) -> void:
	shake_intensity = intensity
	shake_fade = fade_speed

func die() -> void:
	if not controls_allowed:
		return
		
	current_lives -= 1
	lives_changed.emit(current_lives)
	
	screen_shake(8.0)
	
	if current_lives <= 0:
		GameManager.total_coins = 0
		get_tree().reload_current_scene()
	else:
		controls_allowed = false
		global_position = respawn_position
		velocity = Vector2.ZERO
		get_tree().create_timer(0.4).timeout.connect(func(): controls_allowed = true)
		
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		print("paused")
		var pause_menu = get_node("/root/Game/HUD/PauseMenu")
		if pause_menu:
			pause_menu.toggle_pause()
