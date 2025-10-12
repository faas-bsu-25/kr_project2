@icon("res://assets/node-icons/icon_gem-node2D.png")
@tool
class_name Pickup
extends Area2D

enum Type {
	BEAN,
	BOMB,
	COIN,
	HALF_HEART,
	HEART,
	INGOT,
	KEY,
	POTION,
}

@export var pickup_type: Type = Type.BEAN:
	set(new_type):
		pickup_type = new_type
		
		var _tool_change_name: Callable = func(type: Type) -> void:
			Sprite.animation = _tool_anim_from_type(type)
		
		_tool_change_name.call_deferred(new_type)

@onready var Shape: CollisionShape2D = $Shape
@onready var Sprite: AnimatedSprite2D = $Sprite


static func _tool_anim_from_type(type: Type) -> StringName:
	match (type):
		Type.BEAN:
			return &"bean"
		Type.BOMB:
			return &"bomb"
		Type.COIN:
			return &"coin"
		Type.HALF_HEART:
			return &"half_heart"
		Type.HEART:
			return &"heart"
		Type.INGOT:
			return &"ingot"
		Type.KEY:
			return &"key"
		Type.POTION:
			return &"potion"
		
		_:
			return &"bean"


func _ready() -> void:
	self.connect("body_entered", _on_picked_up)
	Sprite.play()


func _on_picked_up(body: Node2D) -> void:
	if body is Player:
		PickupEventBus.picked_up.emit(self.pickup_type)
		self.queue_free()
