extends CharacterBody2D

const SPEED = 150.0
const JUMP_VELOCITY = -350.0
@export var max_lives : int = 5
var current_lives : int
var shake_intensity : float = 0.0
var shake_fade : float = 5.0
var is_turning : bool = false
@onready var PauseMenu = $"../HUD/PauseMenu"
@onready var camera = $Camera2D
@export var respawn_position : Vector2
var can_double_jump: bool = true

func _ready() -> void:
	respawn_position = global_position
	current_lives = max_lives
	await get_tree().process_frame
	GameManager.player_lives_changed.emit(current_lives)

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	if GameManager.controls_allowed:
		if Input.is_action_just_pressed("jump") and is_on_floor():
			velocity.y = JUMP_VELOCITY
		if is_on_floor():
			can_double_jump = true
		if Input.is_action_just_pressed("jump") and not is_on_floor() and GameManager.has_double_jump == true and can_double_jump == true:
			velocity.y = -400.0
			can_double_jump = false
		var direction := Input.get_axis("move_left", "move_right")
		if direction:
			velocity.x = direction * SPEED
			if ((direction < 0 and not $AnimatedSprite2D.flip_h) or (direction > 0 and $AnimatedSprite2D.flip_h)) and not is_turning:
				is_turning = true
				$AnimatedSprite2D.play("turn")
				get_tree().create_timer(0.07).timeout.connect(func(): is_turning = false)
			if not is_turning and is_on_floor():
				$AnimatedSprite2D.play("run")
			$AnimatedSprite2D.flip_h = (direction < 0)
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			if is_on_floor() and not is_turning:
				$AnimatedSprite2D.play("idle")
		if not is_on_floor() and velocity.y > 0:
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
	if not GameManager.controls_allowed:
		return
		
	current_lives -= 1
	GameManager.player_lives_changed.emit(current_lives)
	screen_shake(8.0)
	
	if current_lives <= 0:
		GameManager.deaths += 1 
		GameManager.total_coins = 0
		hide()
		TransitionLayer.change_scene("res://scenes/main_menu.tscn")
	else:
		GameManager.controls_allowed = false
		velocity = Vector2.ZERO
		hide()
		await TransitionLayer.fade_in()
		global_position = respawn_position
		$AnimatedSprite2D.play("idle")
		show()
		await TransitionLayer.fade_out()
		GameManager.controls_allowed = true
		
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		if PauseMenu:
			PauseMenu.toggle_pause()


func _on_cutscene_body_entered(body: Node2D) -> void:
	if body.name == "player":
		GameManager.controls_allowed = false
		$AnimatedSprite2D.play("idle")
		await TransitionLayer.fade_in()
		camera.reset_smoothing()
		camera.force_update_scroll()
		camera.position_smoothing_enabled = false
		get_parent().get_node("Cutscene/AnimationPlayer").play("intro_sequence")
		await TransitionLayer.fade_out()
		await get_parent().get_node("Cutscene/AnimationPlayer").animation_finished
		TransitionLayer.change_scene("res://scenes/Cutscene1.tscn")
		
		
		
