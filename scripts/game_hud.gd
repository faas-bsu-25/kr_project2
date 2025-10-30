@icon("res://assets/node-icons/icon_text_panel.png")
class_name GameHUD
extends Control

@onready var BombsLabel: Label = $BombsAndKeys/Bombs/BombsLabel
@onready var KeysLabel: Label = $BombsAndKeys/Keys/KeysLabel

func _ready() -> void:
	PickupEventBus.picked_up.connect(_update_and_ignore)
	PickupEventBus.use_bomb.connect(_update)
	PickupEventBus.use_key.connect(_update)

func _update_and_ignore(_ignored: Variant) -> void:
	_update()

func _update() -> void:
	BombsLabel.text = str(PickupEventBus.bombs)
	KeysLabel.text = str(PickupEventBus.keys)
	
