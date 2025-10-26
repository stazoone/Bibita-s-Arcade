extends CanvasLayer

@onready var button_resume = $Panel/ButtonResume
@onready var button_main_menu = $Panel/ButtonMainMenu

func _ready():
	visible = false
	process_mode = Node.PROCESS_MODE_ALWAYS
	button_resume.pressed.connect(_on_resume_pressed)
	button_main_menu.pressed.connect(_on_main_menu_pressed)

func _input(event):
	if _is_in_main_menu():
		return
	if event.is_action_pressed("ui_cancel"):
		_toggle_pause()

func _toggle_pause():
	if get_tree().paused:
		_resume_game()
	else:
		_pause_game()

func _pause_game():
	get_tree().paused = true
	visible = true

func _resume_game():
	get_tree().paused = false
	visible = false

func _on_resume_pressed():
	_resume_game()

func _on_main_menu_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Main Menu/main_menu.tscn")

func _is_in_main_menu() -> bool:
	var current_scene = get_tree().current_scene
	if current_scene == null:
		return false
	return current_scene.scene_file_path.ends_with("res://Main Menu/main_menu.tscn")
