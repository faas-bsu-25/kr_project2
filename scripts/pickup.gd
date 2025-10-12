@icon("res://assets/node-icons/icon_gem.png")
@tool
class_name Pickup
extends Area2D

enum ItemType {
	BEAN,
	BOMB,
	COIN,
	HALF_HEART,
	HEART,
	INGOT,
	KEY,
	POTION,
}

@export var pickup_type: ItemType = ItemType.BEAN:
	set(new_type):
		pickup_type = new_type
		
		var tool_change_name: Callable = func(type: ItemType) -> void:
			var tool_sprite: AnimatedSprite2D = self.get_child(1) as AnimatedSprite2D
			tool_sprite.animation = _tool_anim_from_type(type)
		
		tool_change_name.call_deferred(new_type)

@onready var Shape: CollisionShape2D = $Shape
@onready var Sprite: AnimatedSprite2D = $Sprite


static func _tool_anim_from_type(type: ItemType) -> StringName:
	match (type):
		ItemType.BEAN:
			return &"bean"
		ItemType.BOMB:
			return &"bomb"
		ItemType.COIN:
			return &"coin"
		ItemType.HALF_HEART:
			return &"half_heart"
		ItemType.HEART:
			return &"heart"
		ItemType.INGOT:
			return &"ingot"
		ItemType.KEY:
			return &"key"
		ItemType.POTION:
			return &"potion"
		
		_:
			return &"bean"


func _ready() -> void:
	self.connect("body_entered", _on_picked_up)
	Sprite.play()


func _on_picked_up(body: Node2D) -> void:
	if body is Player:
		Signals.item_picked_up.emit(Sprite.animation)
		self.queue_free()
