extends CharacterBody2D

const SPEED = 50.0
var attacking = false

func _ready():
	$AnimatedSprite2D.animation = "idle"
	$AnimatedSprite2D.play()

func _physics_process(delta: float) -> void:
	var direction := Vector2(
		Input.get_axis("ui_left", "ui_right"),
		Input.get_axis("ui_up", "ui_down")
	)
	
	if direction != Vector2.ZERO:
		direction = direction.normalized()
		velocity = direction * SPEED
		if $AnimatedSprite2D.animation != "walk" and !attacking:
			$AnimatedSprite2D.play("walk")
	else:
		velocity = Vector2.ZERO
		if $AnimatedSprite2D.animation != "idle" and !attacking:
			$AnimatedSprite2D.play("idle")

	if direction.x != 0:
		$AnimatedSprite2D.flip_h = direction.x < 0

	if Input.is_action_just_pressed("ui_accept"):
		attacking = true
		$AnimatedSprite2D.play("attack")
		$AnimatedSprite2D.connect("animation_finished", Callable(self, "_on_attack_finished"))

	move_and_slide()

func _on_attack_finished():
	if $AnimatedSprite2D.animation == "attack":
		attacking = false
