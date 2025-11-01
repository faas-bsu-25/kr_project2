@icon("res://assets/node-icons/icon_cell.png")
# class_name TileEventBus
extends Node
## handles events related to Tiles interacted with by the player's sword


signal tile_fired(tile: Node)


func _ready() -> void:
	tile_fired.connect(_handle_tile)
	pass


func _handle_tile(tile: Node) -> void:
	if tile is Pot:
		$PotShatterSound.play()
		tile.queue_free()
	elif tile is Chest:
		$ChestOpenSound.play()
	elif tile is LockedDoor:
		if PickupEventBus.keys >= 1:
			PickupEventBus.use_key.emit()
			$DoorOpenSound.play()
			tile.queue_free()
		else:
			$DoorLockedSound.play()
