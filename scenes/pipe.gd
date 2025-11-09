extends Area2D

signal hit
signal scored
@export var amplitude := 30.0  # How far up/down the pipe moves
@export var speed := 2.0       # How fast it oscillates

var base_y := 0.0
var time := 0.0
func _ready() -> void:
	base_y = position.y
	
func _process(delta):
	time += delta * speed
	position.y = base_y + sin(time) * amplitude
	
func _on_body_entered(body):
	hit.emit()

func _on_score_area_body_entered(body):
	scored.emit()
