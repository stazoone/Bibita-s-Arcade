extends TextureButton


func _ready():
	# Create bitmap from the texture's alpha channel
	var bitmap = BitMap.new()
	var image = texture_normal.get_image()
	bitmap.create_from_image_alpha(image, 0.1)  # 0.1 = alpha threshold
	texture_click_mask = bitmap
	pressed.connect(_on_pressed)


func _on_pressed():
	get_tree().change_scene_to_file("res://Vulcano/Scenes/vulcano.tscn")
