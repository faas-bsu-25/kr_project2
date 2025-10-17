@icon("res://assets/node-icons/icon_sword.png")
class_name Sword
extends Area2D


const _ACTIVATION_FRAME: int = 2
const _DEACTIVATION_FRAME: int = 4

@export var show_hurtbox: bool = false;

var is_swinging: bool = false
var _hit_a_pot: bool = false

@onready var Sprite: AnimatedSprite2D = $Sprite
@onready var HurtboxPreview: Polygon2D = $HurtboxPreview
@onready var SwingSound: AudioStreamPlayer = $SwingSound


func _process(_delta: float) -> void:
	if _within_activation_frames() and not self.monitoring:
		_activate_hurtbox()
	elif not _within_activation_frames() and self.monitoring:
		_deactivate_hurtbox()


func _on_body_entered(body: Node2D) -> void:
	if body is Pot:
		body.shatter()


func _on_sprite_animation_finished() -> void:
	is_swinging = false
	_hit_a_pot = false


func _within_activation_frames() -> bool:
	var within_frame_window: bool = Sprite.frame >= _ACTIVATION_FRAME and Sprite.frame < _DEACTIVATION_FRAME
	return not _hit_a_pot and within_frame_window


func _activate_hurtbox() -> void:
	SwingSound.play()
	self.monitoring = true
	
	if show_hurtbox:
		HurtboxPreview.visible = true


func _deactivate_hurtbox() -> void:
	self.monitoring = false
	HurtboxPreview.visible = false


func swing(angle_rad: float) -> void:
	self.rotation = angle_rad
	is_swinging = true
	Sprite.play("swing")
