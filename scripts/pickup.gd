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

const SCENE: PackedScene = preload("res://components/pickup.tscn")

@export var pickup_type: Type = Type.BEAN:
	set(new_type):
		pickup_type = new_type
		
		var _tool_change_name: Callable = func(type: Type) -> void:
			Sprite.animation = _tool_anim_from_type(type)
		
		_tool_change_name.call_deferred(new_type)

@onready var Shape: CollisionShape2D = $Shape
@onready var Sprite: AnimatedSprite2D = $Sprite


static func new_pickup(type: Pickup.Type) -> Pickup:
	var pickup: Pickup = SCENE.instantiate()
	(func() -> void: pickup.pickup_type = type).call_deferred()
	return pickup


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
	self.connect("area_entered", _on_picked_up)
	Sprite.play()


func _pick_me_up() -> void:
	PickupEventBus.picked_up.emit(self.pickup_type)
	self.queue_free()


func _on_picked_up(body_or_area: Node2D) -> void:
	var is_player: bool = body_or_area is Player
	var is_sword: bool = body_or_area is Sword and (body_or_area as Sword).is_swinging
	
	if is_player or is_sword:
		_pick_me_up()
