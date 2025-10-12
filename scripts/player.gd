@icon("res://assets/node-icons/icon_character.png")
class_name Player
extends CharacterBody2D


enum State {
	IDLE,
	WALK,
	#HIT,
	#DEFEATED,
	#FALL,
	#END,
}

const MOVE_SPEED: float = 8000.0
@export var state: State = State.IDLE
var flipped: bool = false
@onready var Sprite: Sprite2D = $Sprite


func _ready() -> void:
	pass


func _process(_delta: float) -> void:
	self.state = _determine_state()
	_flip_if_necessary()


func _physics_process(delta: float) -> void:
	var move_dir: Vector2 = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	self.velocity = move_dir * MOVE_SPEED * delta
	
	move_and_slide()


func _determine_state() -> State:
	if self.velocity == Vector2.ZERO:
		return State.IDLE
	else:
		return State.WALK


func _flip_if_necessary() -> void:
	## order matters for short-circuiting
	if not flipped and velocity.x < 0:
		_flip()
	elif flipped and velocity.x > 0:
		_unflip()

func _flip() -> void:
	Sprite.flip_h = true
	flipped = true

func _unflip() -> void:
	Sprite.flip_h = false
	flipped = false
