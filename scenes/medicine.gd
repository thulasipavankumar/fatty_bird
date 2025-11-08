extends Area2D

signal recover
@onready var recover_music: AudioStreamPlayer = $recover_sound
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _on_body_entered(body: Node2D) -> void:
	recover.emit()
	recover_music.play()
	pass # Replace with function body.
