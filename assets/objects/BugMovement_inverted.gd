extends KinematicBody2D

var jumpvelocity = 600.0
var walkspeed = 100.0
var horizontal_damping = 0.8
var gravityscale = 1600.0

var velocity = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):

func _physics_process(delta):
		
	if !Input.is_action_pressed("ui_select"):
		if !Input.is_action_pressed("ui_select"):
			var blend = 1 - pow(0.001, horizontal_damping * delta)
			velocity.x = lerp(velocity.x, 0, blend)
		if Input.is_action_pressed("ui_right"):
			velocity.x -= walkspeed
		elif Input.is_action_pressed("ui_left"):
			velocity.x += walkspeed
	

	if $CeilingRayCast2D.is_colliding() or $CeilingRayCast2D2.is_colliding():
		velocity.y = max(velocity.y, 0)
	
	if is_on_floor():
		if Input.is_action_pressed("ui_up") and !Input.is_action_pressed("ui_select"):
			velocity.y = -jumpvelocity
		else:
			velocity.y = 0
	else:
		if !Input.is_action_pressed("ui_select"):
			velocity.y += gravityscale * delta * 0.5
	
	if Input.is_action_pressed("ui_select"):
		velocity.y = 0
		velocity.x = 0
	move_and_slide(velocity, Vector2.UP)
	
	if !is_on_floor() and !Input.is_action_pressed("ui_select"):
			velocity.y += gravityscale * delta * 0.5
