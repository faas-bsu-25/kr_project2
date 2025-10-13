class_name Pot
extends StaticBody2D


func shatter() -> void:
	var coin: Pickup = Pickup.new_pickup(Pickup.Type.COIN)
	coin.position = self.position
	add_sibling.call_deferred(coin)
	
	self.queue_free()
