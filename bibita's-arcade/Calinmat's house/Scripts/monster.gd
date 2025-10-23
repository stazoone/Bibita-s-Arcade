extends Button

@export var monster_id: int
var is_flipped = false
signal flipped(card)

func _ready():
	$Front.texture = load("res://Calinmat's house/PNGs/front_%d.png" % monster_id)
	show_back()  

func show_front():
	$Front.show()
	$Back.hide()
	is_flipped = true

func show_back():
	$Front.hide()
	$Back.show()
	is_flipped = false

func _on_pressed():
	if not is_flipped:
		show_front()
		emit_signal("flipped", self)
