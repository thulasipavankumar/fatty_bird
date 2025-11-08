extends Node

@export var pipe_scene : PackedScene
@export var food_scene : PackedScene
@export var medicine_scene : PackedScene
@onready var player_hit_sound: AudioStreamPlayer = $player_hit

var game_running : bool
var game_over : bool
var instruction_required: bool = true
var scroll
var score
var coins
const SCROLL_SPEED : int = 4
var screen_size : Vector2i
var ground_height : int
var pipes : Array
var foods: Array
var medicines: Array
const PIPE_DELAY : int = 100
const PIPE_RANGE : int = 200

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_window().size
	ground_height = $Ground.get_node("Sprite2D").texture.get_height()
	new_game()
	
func check_show_instructions():
	if instruction_required == true:
		$Instructions.show()
	else:
		$Instructions.hide()
	
func new_game():
	check_show_instructions()
	#reset variables
	game_running = false
	game_over = false
	score = 0
	scroll = 0
	coins = 0
	$ScoreLabel.text = "SCORE: " + str(score)
	$CoinsLabel.text = ": " + str(coins)
	$GameOver.hide()
	get_tree().call_group("pipes", "queue_free")
	get_tree().call_group("foods", "queue_free")
	get_tree().call_group("medicines", "queue_free")
	pipes.clear()
	foods.clear()
	medicines.clear()
	#generate starting pipes
	generate_assets()
	$Bird.reset()
	
func generate_assets():
	generate_pipes()
	generate_foods()
	generate_medicines()
	
func _input(event):
	if game_over == false && instruction_required == false:
		if event is InputEventMouseButton:
			if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
				if  game_running == false:
					start_game()
				else:
					if $Bird.flying:
						$Bird.flap()
						check_top()

func start_game():
	game_running = true
	$Bird.flying = true
	$Bird.flap()
	#start timer
	start_timers()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if game_running:
		scroll += SCROLL_SPEED
		#reset scroll
		if scroll >= screen_size.x:
			scroll = 0
		#move ground node
		$Ground.position.x = -scroll
		#move pipes
		for pipe in pipes:
			pipe.position.x -= SCROLL_SPEED
		for food in foods:
			food.position.x -= SCROLL_SPEED
		for medicine in medicines:
			medicine.position.x -= SCROLL_SPEED	


func _on_pipe_timer_timeout():
	generate_pipes()

func _on_food_timer_timeout() -> void:
	generate_foods()
	pass
	
func _on_medicine_timer_timeout() -> void:
	generate_medicines()
	pass

func generate_pipes():
	var pipe = pipe_scene.instantiate()
	pipe.position.x = screen_size.x + PIPE_DELAY
	pipe.position.y = (screen_size.y - ground_height) / 2  + randi_range(-PIPE_RANGE, PIPE_RANGE)
	pipe.hit.connect(bird_hit)
	pipe.scored.connect(scored)
	add_child(pipe)
	pipes.append(pipe)

func generate_foods():
	var food = food_scene.instantiate()
	food.position.x = screen_size.x + PIPE_DELAY
	food.position.y = (screen_size.y - ground_height) / 2  + randi_range(-PIPE_RANGE, PIPE_RANGE)
	food.eat.connect(bird_eats)
	add_child(food)
	foods.append(food)
	pass

func generate_medicines():
	var medicine = medicine_scene.instantiate()
	medicine.position.x = screen_size.x + PIPE_DELAY
	medicine.position.y = (screen_size.y - ground_height) / 2  + randi_range(-PIPE_RANGE, PIPE_RANGE)
	medicine.recover.connect(bird_recovers)
	add_child(medicine)
	medicines.append(medicine)
	pass
	
func scored():
	score += 1
	coins += 3
	$ScoreLabel.text = "SCORE: " + str(score)
	$CoinsLabel.text = ": " + str(coins)

func check_top():
	if $Bird.position.y < 0:
		$Bird.falling = true
		stop_game()

func stop_game():
	stop_timers()
	$GameOver.show()
	$Bird.flying = false
	game_running = false
	game_over = true
	
func stop_timers():
	$PipeTimer.stop()
	$FoodTimer.stop()
	$MedicineTimer.stop()

func start_timers():
	$PipeTimer.start()
	$FoodTimer.start()
	$MedicineTimer.start()
	
	
func bird_hit():
	player_hit_sound.play()
	$Bird.falling = true
	stop_game()
	
func bird_eats():
	$Bird.scale_up()
	pass
	
func bird_recovers():
	$Bird.scale_down()
	pass

func _on_ground_hit():
	$Bird.falling = false
	stop_game()

func _on_game_over_restart():
	new_game()


func _on_instructions_instructions() -> void:
	instruction_required = false
	new_game()
	pass # Replace with function body.
