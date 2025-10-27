@icon("res://assets/node-icons/icon_door.png")
class_name Door
extends StaticBody2D

func unlock() -> void:
	TileEventBus.tile_fired.emit(self)
