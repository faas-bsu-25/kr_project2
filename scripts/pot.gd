@icon("res://assets/node-icons/icon_pot.png")
class_name Pot
extends StaticBody2D

@export var drops: Array[Pickup.Type] = [Pickup.Type.COIN]
@export_range(0, 50, 0.1, "suffix:px") var drop_range: float = 20

func shatter() -> void:
	for drop: Pickup.Type in drops:
		var random_offset_pos: Vector2 = Vector2(
			randf_range(-drop_range, drop_range), 
			randf_range(-drop_range, drop_range))
		
		var dropped_pickup: Pickup = Pickup.new_pickup(drop, true)
		dropped_pickup.position = self.position + random_offset_pos
		add_sibling.call_deferred(dropped_pickup)
	
	TileEventBus.tile_fired.emit(self)
