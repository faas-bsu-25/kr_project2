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

@export var pickup_type: Type = Type.BEAN

@export_subgroup("Delay")
@export var has_pickup_delay: bool = false;
@export_custom(PROPERTY_HINT_NONE, "suffix:seconds") var delay_for: float = 3.0
@export_subgroup("")

@onready var Sprite: AnimatedSprite2D = $Sprite
@onready var PickupDelayTimer: Timer = $PickupDelayTimer


static func new_pickup(type: Pickup.Type, has_delay: bool) -> Pickup:
	var pickup: Pickup = SCENE.instantiate()
	
	## deferred not because of itself, but because it triggers
	## pickup_type: set(type): ...
	## this requires the Sprite to be loaded, so it must be delayed
	## until after this is the case. failure to defer will cause
	## an immediate runtime crash.
	(func() -> void: pickup.pickup_type = type).call_deferred()
	pickup.has_pickup_delay = has_delay
	
	return pickup


static func _anim_from_type(type: Type) -> StringName:
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
	
	if self.has_pickup_delay:
		self.monitoring = false
		PickupDelayTimer.start()


func _process(_delta: float) -> void:
	if (Sprite.animation != _anim_from_type(pickup_type)):
		Sprite.animation = _anim_from_type(pickup_type)


func _on_pickup_delay_timer_timeout() -> void:
	self.monitoring = true


func _pick_me_up() -> void:
	PickupEventBus.picked_up.emit(self.pickup_type)
	self.queue_free()


func _on_picked_up(body_or_area: Node2D) -> void:
	var is_player: bool = body_or_area is Player
	var is_sword: bool = body_or_area is Sword and (body_or_area as Sword).is_swinging
	
	if is_player or is_sword:
		_pick_me_up()
