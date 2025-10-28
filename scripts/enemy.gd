@icon("res://assets/node-icons/icon_skull.png")
@tool
class_name Enemy
extends CharacterBody2D


enum State { WAIT, CHASE, HIT }

static var _slime_anims: Array[String] = ["slime_default", "slime_hit"]
static var _bat_anims: Array[String] = ["bat_default", "bat_hit"]

@export_enum("Slime", "Bat") var preset: String = "Slime":
	set(new_preset):
		preset = new_preset
		
		match new_preset:
			"Slime":
				health = 3
				speed = 1200.0
				knockback_factor = 8.0
				_my_anims = _slime_anims
			"Bat":
				health = 1
				speed = 1800.0
				knockback_factor = 10.0
				_my_anims = _bat_anims
		
		var update_anims: Callable = func() -> void: 
			Sprite.animation = _my_anims[0]
			Sprite.play()
		
		update_anims.call_deferred()

@export var health: int = 3;

@export var drops: Array[Pickup.Type] = [Pickup.Type.HALF_HEART]
@export_range(0, 50, 0.1, "suffix:px") var drop_range: float = 20

@export_group("Movement")
@export var state: State = State.WAIT
@export var speed: float = 1200.0
@export var knockback_factor: float = 8.0

var target: Player
var _my_anims: Array[String] = _slime_anims

@onready var Sprite: AnimatedSprite2D = $Sprite


func _ready() -> void:
	Sprite.play()


func _process(_delta: float) -> void:
	if Engine.is_editor_hint(): return
	
	if target == null and state == State.CHASE:
		change_to(State.WAIT)
	elif target != null and state == State.WAIT:
		change_to(State.CHASE)


func _physics_process(delta: float) -> void:
	if Engine.is_editor_hint(): return

	if target == null or state == State.WAIT:
		self.velocity = Vector2.ZERO
	
	else:
		var angle_to_player: float = self.get_angle_to(target.position)
		var direction_to_player: Vector2 = Vector2.from_angle(angle_to_player).normalized()
			
		self.velocity = direction_to_player * speed * delta
		if state == State.HIT: self.velocity *= knockback_factor * -1
	
	move_and_slide()


func _on_detection_area_body_entered(body: Node2D) -> void:
	if body is Player:
		target = body


func _on_detection_area_body_exited(body: Node2D) -> void:
	if body is Player:
		target = null


func change_to(new_state: State) -> void:
	self.state = new_state
	
	match (state):
		State.WAIT:
			Sprite.sprite_frames.set_animation_speed(_my_anims[0], 1.5)
		State.CHASE:
			Sprite.sprite_frames.set_animation_speed(_my_anims[0], 5.0)
		State.HIT:
			Sprite.animation = _my_anims[1]
			Sprite.play()
			health -= 1


func _on_sprite_animation_finished() -> void:
	if Sprite.animation == _my_anims[1]:
		if health <= 0:
			_die()
		
		change_to(State.WAIT)
		Sprite.animation = _my_anims[0]
		Sprite.play()


func _die() -> void:
	for drop: Pickup.Type in drops:
		var random_offset_pos: Vector2 = Vector2(
			randf_range(-drop_range, drop_range), 
			randf_range(-drop_range, drop_range))
		
		var dropped_pickup: Pickup = Pickup.new_pickup(drop, true)
		dropped_pickup.position = self.position + random_offset_pos
		add_sibling.call_deferred(dropped_pickup)
	
	self.queue_free()
