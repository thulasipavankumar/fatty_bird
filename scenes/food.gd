extends Area2D

signal hit
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	print("Entered Body")
	hit.emit()
	pass # Replace with function body.

#
#func _on_cheese_area_body_entered(body: Node2D) -> void:
	#print("Eaten Cheese")
	#pass # Replace with function body.
#
#
#func _on_burger_area_body_entered(body: Node2D) -> void:
	#print("Eaten burger")
	#pass # Replace with function body.
#
#
#func _on_croissant_area_body_entered(body: Node2D) -> void:
	#print("Eaten croissant")
	#pass # Replace with function body.
#
#
#func _on_cake_area_body_entered(body: Node2D) -> void:
	#print("Eaten cake")
	#pass # Replace with function body.
