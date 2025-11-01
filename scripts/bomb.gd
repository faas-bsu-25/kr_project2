@icon("res://assets/node-icons/icon_area_damage.png")
class_name Bomb
extends Area2D


static var _SCENE: PackedScene = preload("res://components/bomb.tscn")

@export_range(0.0, 10.0, 0.01, "suffix:s") var time_until_explode: float = 3.0
@export var timer_gradient: Gradient = Gradient.new()
@onready var points_in_gradient: int = timer_gradient.get_point_count()

@onready var ExpShape: CollisionShape2D = $Shape
@onready var Sprite: Sprite2D = $Sprite
@onready var ExpTimer: Timer = $ExplosionTimer
@onready var DespawnTimer: Timer = $DespawnTimer


static func new_bomb() -> Bomb:
	return _SCENE.instantiate()

func _ready() -> void:
	ExpTimer.start(time_until_explode)


func _process(_delta: float) -> void:
	var time_left_ratio: float = ExpTimer.time_left / ExpTimer.wait_time
	var gradient_time_index: int = int(points_in_gradient * time_left_ratio) - 1
	
	if gradient_time_index < 0 or gradient_time_index > points_in_gradient:
		return
	else:
		self.modulate = timer_gradient.get_color(gradient_time_index)
		Sprite.scale += Vector2(0.01, 0.01)
		


func _on_body_entered(body: Node2D) -> void:
	if body is CrackedBlock:
		body.queue_free()
	elif body is Pot:
		body.shatter()
		TileEventBus.tile_fired.emit(body)
	elif body is Enemy:
		body.change_to(Enemy.State.HIT)


func _on_explosion_timer_timeout() -> void:
	_explode()


func _on_despawn_timer_timeout() -> void:
	self.queue_free()


func _explode() -> void:
	self.monitoring = true
	self.visible = false
	$BombExplodeSound.play()
	DespawnTimer.start()
