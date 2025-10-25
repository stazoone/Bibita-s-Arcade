extends Node2D

@onready var towers = preload("res://Vulcano/Scenes/towers.tscn")
var gameWidth = DisplayServer.window_get_size() 

func _ready() -> void:
	Autoload.score = 0

func _process(delta: float) -> void:
	$CanvasLayer/Control/Label.text = str(Autoload.score)

func _on_timer_timeout() -> void:
	var towersInstance = towers.instantiate()
	towersInstance.position.x = gameWidth[0]
	towersInstance.position.y = randi_range(0,250)
	add_child(towersInstance)
	$Timer.start()
	
