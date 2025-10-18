@icon("res://assets/node-icons/icon_chest.png")
class_name Chest
extends StaticBody2D


@export var loot: Pickup.Type = Pickup.Type.KEY
@export var opened: bool = false

@onready var Sprite: AnimatedSprite2D = $Sprite


func open() -> void:
	if opened:
		return
	
	TileEventBus.tile_fired.emit(self)
	opened = true
	Sprite.play("chest")
	
	var pickup: Pickup = Pickup.new_pickup(loot, true)
	pickup.position = self.position
	add_sibling.call_deferred(pickup)
