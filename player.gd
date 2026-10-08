extends Sprite2D

# Geschwindigkeit in Pixel pro Sekunde
@export var speed: float = 400.0

var clicks: int = 0
var counter_label: Label

@warning_ignore("unused_signal")
signal health_depleted(final_score: int)

func _ready() -> void:
	print("Player initialisiert am BRG Kepler!")

	# Anzeige-Label in einem CanvasLayer (bleibt fix am Bildschirm)
	var layer := CanvasLayer.new()
	add_child(layer)

	counter_label = Label.new()
	counter_label.position = Vector2(20, 20)
	counter_label.add_theme_font_size_override("font_size", 32)
	counter_label.text = "Klicks: 0"
	layer.add_child(counter_label)

func _input(event: InputEvent) -> void:
	# Linksklick zählen
	if event is InputEventMouseButton \
			and event.pressed \
			and event.button_index == MOUSE_BUTTON_LEFT:
		clicks += 1
		counter_label.text = "Klicks: %d" % clicks

func _process(delta: float) -> void:
	var direction: Vector2 = Vector2.ZERO

	if Input.is_action_pressed("move_right"):
		direction.x += 1
	if Input.is_action_pressed("move_left"):
		direction.x -= 1
	if Input.is_action_pressed("move_down"):
		direction.y += 1
	if Input.is_action_pressed("move_up"):
		direction.y -= 1

	if direction.length() > 0:
		direction = direction.normalized()

	position += direction * speed * delta

func take_damage() -> void:
	health_depleted.emit(100)
