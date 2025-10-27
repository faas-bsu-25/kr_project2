@icon("res://assets/node-icons/icon_cell.png")
# class_name TileEventBus
extends Node
## handles events related to Tiles interacted with by the player's sword


signal tile_fired(tile: Node)

signal bomb_exploded(tile: Node)


func _ready() -> void:
	tile_fired.connect(_handle_tile)
	bomb_exploded.connect(_handle_explosion)
	pass


func _handle_tile(tile: Node) -> void:
	if tile is Pot:
		$PotShatterSound.play()
		tile.queue_free()
	elif tile is Chest:
		$ChestOpenSound.play()
	elif tile is Door:
		print("door event")
		print("keys: %d" % PickupEventBus.keys)
		if PickupEventBus.keys >= 1:
			$DoorOpenSound.play()
			PickupEventBus.keys -= 1
			tile.queue_free()
			print("open")
		else:
			$DoorLockedSound.play()
			print("locked")


func _handle_explosion(tile: Node) -> void:
	if tile is CrackedBlock:
		tile.queue_free()
	elif tile is Pot:
		tile.shatter()
		_handle_tile(tile)
