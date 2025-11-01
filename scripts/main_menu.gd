@icon("res://assets/node-icons/icon_parchment.png")
extends Control


const DEBUG_LEVEL_SCENE: PackedScene = preload("res://components/levels/debug_level.tscn")
const SHOWCASE_LEVEL_SCENE: PackedScene = preload("res://components/levels/showcase_level.tscn")


func _ready() -> void:
	PickupEventBus.bombs = 0
	PickupEventBus.keys = 0


func _on_debug_button_up() -> void:
	get_tree().change_scene_to_packed(DEBUG_LEVEL_SCENE)


func _on_showcase_button_up() -> void:
	get_tree().change_scene_to_packed(SHOWCASE_LEVEL_SCENE)
