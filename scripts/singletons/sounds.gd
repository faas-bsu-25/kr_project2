@icon("res://assets/node-icons/icon_audio.png")
extends Node


func _ready() -> void:
	Signals.item_picked_up.connect(_on_item_picked_up)

func _on_item_picked_up(pickup: String) -> void:
	match (pickup):
		"key":
			$PickupKeySound.play()
		"heart":
			$PickupHeartSound.play()
