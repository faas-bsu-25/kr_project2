@icon("res://assets/node-icons/icon_door.png")
@tool
class_name DoorTP
extends Node2D

@export var linked_door: DoorTP:
	set(other_door):
		linked_door = other_door
		
		if other_door.linked_door == null:
			other_door.linked_door = linked_door
	get:
		return linked_door
		
@export_tool_button("Bind to linked door", "FlipWinding") var bind: Callable = func() -> void: self.linked_door.linked_door = self

const TP_OFFSET: float = 48.0

func _on_tp_area_body_entered(body: Node2D) -> void:
	if Engine.is_editor_hint() or linked_door == null:
		return
	
	if body is Player:
		body.position = linked_door.position + (TP_OFFSET * Vector2.from_angle(self.rotation + deg_to_rad(90)))
