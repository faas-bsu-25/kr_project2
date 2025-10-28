@icon("res://assets/node-icons/icon_key.png")
class_name LockedDoor
extends StaticBody2D

func unlock() -> void:
	TileEventBus.tile_fired.emit(self)
