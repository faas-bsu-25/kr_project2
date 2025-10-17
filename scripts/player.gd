@icon("res://assets/node-icons/icon_human_controller.png")
class_name Player
extends CharacterBody2D


enum State {
	IDLE,
	WALKING,
	SWINGING,
	#HIT,
	#DEFEATED,
	#FALL,
	#END,
}

const _MOVE_SPEED: float = 8000.0

@export var state: State = State.IDLE

var _flipped: bool = false
var _last_move_dir: Vector2 = Vector2.RIGHT ## default sprite-facing direction

@onready var Sprite: Sprite2D = $Sprite
@onready var sword: Sword = $Sword


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("swing_sword") and not state == State.SWINGING:
		sword.swing(_last_move_dir.angle())
	
	self.state = _determine_state()
	_flip_if_necessary()


func _physics_process(delta: float) -> void:
	var move_dir: Vector2 = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	if state == State.SWINGING:
		self.velocity = Vector2.ZERO
	else:
		self.velocity = move_dir * _MOVE_SPEED * delta
		## bug: moving up-left or down-right disallows sword swinging
		_last_move_dir = move_dir if move_dir != Vector2.ZERO else _last_move_dir
	
	move_and_slide()


func _determine_state() -> State:
	if (not sword == null) and sword.is_swinging:
		return State.SWINGING
	elif self.velocity == Vector2.ZERO:
		return State.IDLE
	else:
		return State.WALKING


func _flip_if_necessary() -> void:
	## order matters for short-circuiting
	if not _flipped and velocity.x < 0:
		_flip()
	elif _flipped and velocity.x > 0:
		_unflip()

func _flip() -> void:
	Sprite.flip_h = true
	_flipped = true

func _unflip() -> void:
	Sprite.flip_h = false
	_flipped = false
