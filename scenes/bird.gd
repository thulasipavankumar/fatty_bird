extends CharacterBody2D

const GRAVITY : int = 1000
const MAX_VEL : int = 600
const FLAP_SPEED : int = -500
var flying : bool = false
var falling : bool = false
var fact_scale_factor: float = 1.0
var original_scale: Vector2
const START_POS = Vector2(100, 400)

# Called when the node enters the scene tree for the first time.
func _ready():
	original_scale = scale
	reset()

func reset():
	falling = false
	flying = false
	position = START_POS
	reset_scale_character()
	set_rotation(0)

func scale_up():
	print("Fattening bouyyyy")
	scale = scale * 1.25
	pass
	
func reset_scale_character():
	scale = original_scale
	pass
	
func scale_down():
	print("Dieting mode activate")
	if(scale.x >= 0.40 and scale.y >= 0.40):
		scale = scale * 0.8
	pass
	# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if flying or falling:
		velocity.y += GRAVITY * delta
		#terminal velocity
		if velocity.y > MAX_VEL:
			velocity.y = MAX_VEL
		if flying:
			set_rotation(deg_to_rad(velocity.y * 0.05))
			$AnimatedSprite2D.play()
		elif falling:
			set_rotation(PI/2)
			$AnimatedSprite2D.stop()
		move_and_collide(velocity * delta)
	else:
		$AnimatedSprite2D.stop()
		
func flap():
	velocity.y = FLAP_SPEED
