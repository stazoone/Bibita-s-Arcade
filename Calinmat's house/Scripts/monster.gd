extends TextureButton

@export var monster_id: int = -1
@export var back_texture: Texture2D = load("res://Calinmat's house/PNGs/back.png")

var front_texture: Texture2D
var is_flipped: bool = false

signal flipped(card)

func _ready():
	if monster_id == -1:
		monster_id = randi_range(0, 7)
	
	var front_path = "res://Calinmat's house/PNGs/front_%d.png" % monster_id
	front_texture = load(front_path)
	
	if front_texture == null:
		push_error("Failed to load texture: " + front_path)
	
	stretch_mode = TextureButton.STRETCH_KEEP_ASPECT_CENTERED
	ignore_texture_size = true
	custom_minimum_size = Vector2(100, 100)
	
	if not pressed.is_connected(_on_pressed):
		pressed.connect(_on_pressed)
	
	# Start showing the back
	_show_back()

func _on_pressed():
	if not is_flipped and not disabled:
		is_flipped = true
		_show_front()
		emit_signal("flipped", self)

func flip_back():
	is_flipped = false
	_show_back()

func _show_front():
	texture_normal = front_texture
	texture_hover = front_texture
	texture_pressed = front_texture

func _show_back():
	texture_normal = back_texture
	texture_hover = back_texture
	texture_pressed = back_texture
