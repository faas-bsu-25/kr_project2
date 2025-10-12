@icon("res://assets/node-icons/icon_gem-node.png")
#class_name PickupEventBus
extends Node
## handles events related to [Pickup]s picked up by the [Player]


signal picked_up(type: Pickup.Type)


func _ready() -> void:
	picked_up.connect(_handle_pickup)
	pass


func _handle_pickup(type: Pickup.Type) -> void:
	match type:
		Pickup.Type.KEY:
			$Sounds/KeySound.play()
		Pickup.Type.HALF_HEART, Pickup.Type.HEART:
			$Sounds/HeartSound.play()
		
		_: ## default case
			$Sounds/GenericSound.play()
