extends Area2D
var enable_random:bool =true
signal recover
@onready var recover_music: AudioStreamPlayer = $recover_sound
@export var y_min: float = -100.0
@export var y_max: float = 100.0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if !enable_random:
		return
	randomize_potion_position()
	pass # Replace with function body.

func randomize_potion_position():
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
	recover.emit()
	recover_music.play()
	pass # Replace with function body.
