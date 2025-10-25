extends TextureButton


func _ready():
	pressed.connect(_on_pressed)


func _on_pressed():
	get_tree().change_scene_to_file("res://Calinmat's house/Scenes/house.tscn")
