extends Area2D
@export var y_min: float = -100.0
@export var y_max: float = 100.0
@export var enable_random: bool = true
signal hit

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if !enable_random:
		return
	randomize_cheat_position()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func randomize_cheat_position():
	randomize()
	var sprites :Array = []
	var collisions :Array = []
	for child in get_children():
		if child is Sprite2D:
			sprites.append(child)
		elif child is CollisionShape2D:
			collisions.append(child)
	for i in sprites.size():
		var rand_y = randf_range(y_min,y_max)
		sprites[i].position.y = rand_y
		if i < collisions.size():
			collisions[i].position.y = rand_y

func _on_body_entered(body: Node2D) -> void:
	hit.emit()
	pass # Replace with function body.
