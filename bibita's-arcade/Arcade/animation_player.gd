extends AnimationPlayer


func _on_vulcano_mouse_entered() -> void:
	play("vulcano_hover")


func _on_vulcano_mouse_exited() -> void:
	play("vulcano_normal")
