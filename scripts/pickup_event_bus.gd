@icon("res://assets/node-icons/icon_gem-node.png")
#class_name PickupEventBus
extends Node
## handles events related to [Pickup]s picked up by the [Player]


signal picked_up(type: Pickup.Type)
signal use_bomb
signal use_key

var keys: int = 0;
var bombs: int = 0;


func _ready() -> void:
	picked_up.connect(_handle_pickup)
	use_bomb.connect(func() -> void: bombs -= 1)
	use_key.connect(func() -> void: keys -= 1)


func _handle_pickup(type: Pickup.Type) -> void:
	match type:
		Pickup.Type.KEY:
			$Sounds/KeySound.play()
			keys += 1
		Pickup.Type.BOMB:
			$Sounds/GenericSound.play()
			bombs += 1
		Pickup.Type.HALF_HEART:
			$Sounds/HeartSound.pitch_scale = 1.5
			$Sounds/HeartSound.play()
		Pickup.Type.HEART:
			$Sounds/HeartSound.pitch_scale = 1
			$Sounds/HeartSound.play()
		
		_: ## default case
			$Sounds/GenericSound.play()
