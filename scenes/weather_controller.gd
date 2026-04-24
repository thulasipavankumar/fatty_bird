extends Node2D

@onready var rain = $RainParticles
@onready var snow = $SnowParticles
@onready var sun = $Sunlight
@onready var timer = $WeatherTimer

var weather_states = ["sunny", "rain", "snow"]
var current_weather = "sunny"

func _ready():
	_set_weather("sunny")
	timer.timeout.connect(_on_weather_timer_timeout)

func _on_weather_timer_timeout():
	var new_weather = weather_states.pick_random()
	_set_weather(new_weather)

func _set_weather(state: String):
	current_weather = state
	rain.emitting = false
	snow.emitting = false
	sun.visible = false

	match state:
		"rain":
			rain.emitting = true
		"snow":
			snow.emitting = true
		"sunny":
			sun.visible = true

	print("Weather changed to: ", state)
