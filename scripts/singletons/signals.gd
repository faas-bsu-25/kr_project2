@icon("res://assets/node-icons/icon_gear.png")
#class_name GameManager
extends Node


signal item_picked_up(pickup: String)
@export var keys: int = 0;
@export var hearts: int = 0


func _ready() -> void:
	item_picked_up.connect(_on_item_picked_up)


func _on_item_picked_up(pickup: String) -> void:
	match (pickup):
		"key":
			keys += 1
		"heart":
			hearts += 1
