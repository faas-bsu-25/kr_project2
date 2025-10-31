@icon("res://assets/node-icons/icon_sound.png")
extends AudioStreamPlayer

## Not sure why I have to loop this manually but uhhh...
func _on_finished() -> void:
	play()
