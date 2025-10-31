@icon("res://assets/node-icons/icon_text_panel.png")
class_name GameHUD
extends Control


const BOMB_ICON_SCENE: PackedScene = preload("res://components/bomb_icon.tscn")
const KEY_ICON_SCENE: PackedScene = preload("res://components/keys_icon.tscn")

@onready var BombsBox: HBoxContainer = $BombsAndKeys/Bombs
@onready var KeysBox: HBoxContainer = $BombsAndKeys/Keys

func _ready() -> void:
	PickupEventBus.picked_up.connect(_update_and_ignore)
	PickupEventBus.use_bomb.connect(_update)
	PickupEventBus.use_key.connect(_update)

func _update_and_ignore(_ignored: Variant) -> void:
	_update()

func _update() -> void:
	for icon: TextureRect in BombsBox.get_children():
		icon.queue_free()
	for icon: TextureRect in KeysBox.get_children():
		icon.queue_free()
	
	for b: int in range(PickupEventBus.bombs):
		BombsBox.add_child(BOMB_ICON_SCENE.instantiate())
	for k: int in range(PickupEventBus.keys):
		KeysBox.add_child(KEY_ICON_SCENE.instantiate())
