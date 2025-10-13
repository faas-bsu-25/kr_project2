class_name Sword
extends Area2D


@export var is_swinging: bool = false
@onready var AnimPlayer: AnimationPlayer = $AnimationPlayer


func _ready() -> void:
	AnimPlayer.play("RESET")


func swing(angle_rad: float) -> void:
	self.rotation = angle_rad
	
	is_swinging = true
	AnimPlayer.play("swing")
	

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	AnimPlayer.play("RESET")
	
	if anim_name == "swing":
		is_swinging = false


func _on_body_entered(body: Node2D) -> void:
	if body is Pot:
		body.shatter()
