extends Area2D

signal hit

@export var speed: float = 400.0
var screen_size: Vector2

func _ready() -> void:
	screen_size = get_viewport_rect().size
	body_entered.connect(_on_body_entered)
	hide()

func _process(delta: float) -> void:
	if not visible:
		return
	var velocity := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	position += velocity * speed * delta
	position = position.clamp(Vector2.ZERO, screen_size)

func start(pos: Vector2) -> void:
	position = pos
	show()
	$CollisionShape2D.disabled = false

func _on_body_entered(_body) -> void:
	hide()
	hit.emit()
	$CollisionShape2D.set_deferred("disabled", true)
