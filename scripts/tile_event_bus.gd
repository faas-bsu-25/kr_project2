@icon("res://assets/node-icons/icon_cell.png")
# class_name TileEventBus
extends Node
## handles events related to [Pickup]s picked up by the [Player]


signal tile_fired(tile: Node)

signal bomb_exploded(tile: Node)


func _ready() -> void:
	tile_fired.connect(_handle_tile)
	bomb_exploded.connect(_handle_explosion)
	pass


func _handle_tile(tile: Node) -> void:
	if tile is Pot:
		$PotShatterSound.play()
	elif tile is Chest:
		$ChestOpenSound.play()


func _handle_explosion(tile: Node) -> void:
	if tile is CrackedBlock:
		tile.queue_free()
	if tile is Pot:
		tile.shatter()
		_handle_tile(tile)
