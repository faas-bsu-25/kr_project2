@icon("res://assets/node-icons/icon_cell.png")
# class_name TileEventBus
extends Node
## handles events related to [Pickup]s picked up by the [Player]


signal tile_fired(tile: Node)


func _ready() -> void:
	tile_fired.connect(_handle_tile)
	pass

func _handle_tile(tile: Node) -> void:
	if tile is Pot:
		$PotShatterSound.play()
