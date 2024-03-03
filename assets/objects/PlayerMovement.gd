extends KinematicBody2D

var jumpvelocity = 600.0
var walkspeed = 70.0
var horizontal_damping = 0.9999
var gravityscale = 1600.0

var velocity = Vector2()

var player
var clipping = false


# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_parent().get_parent().get_node("Player")
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):



func _physics_process(delta):
	if Input.is_action_just_pressed("ui_select"):
		$AnimatedSprite.stop()
	elif Input.is_action_just_released("ui_select"):
		$AnimatedSprite.play()
	$AnimatedSprite.flip_h = velocity.x < 0
	
		
	if Input.is_action_pressed("ui_select"):
		#velocity += (hang_accel * delta * 0.5) * velocity.normalized()
		pass
	else:
		if Input.is_action_pressed("ui_left"):
			velocity.x -= walkspeed
		elif Input.is_action_pressed("ui_right"):
			velocity.x += walkspeed
	

	if $CeilingRayCast2D.is_colliding() or $CeilingRayCast2D2.is_colliding():
		velocity.y = max(velocity.y, 0)
	
	
	
	if is_on_floor():
		if Input.is_action_pressed("ui_up") and !Input.is_action_pressed("ui_select"):
			velocity.y = -jumpvelocity
		else:
			velocity.y = 0
		
		if clipping:
			$AnimatedSprite.animation = "clip"
		else:
			if abs(velocity.x) < 15:
				$AnimatedSprite.animation = "idle"
	else:
		if !Input.is_action_pressed("ui_select"):
			velocity.y += gravityscale * delta * 0.5
	
	if !Input.is_action_pressed("ui_select"):
		var blend = 1 - pow(0.001, horizontal_damping * delta)
		velocity.x = lerp(velocity.x, 0, blend)
	
	move_and_slide(velocity, Vector2.UP)
	

	
	if !is_on_floor() and !Input.is_action_pressed("ui_select"):
			velocity.y += gravityscale * delta * 0.5
	
	if Input.is_action_pressed("ui_select"):
		#velocity += (hang_accel * delta * 0.5) * velocity.normalized()
		pass
		
	
	if clipping:
		$AnimatedSprite.animation = "clip"
	else:
		if velocity.y < -30:
			if abs(velocity.x) > 15:
				$AnimatedSprite.animation = "run"
			else:
				$AnimatedSprite.animation = "jump"
		else:
			if abs(velocity.x) > 15:
				$AnimatedSprite.animation = "run"
			else:
	#			$AnimatedSprite.animation = "idle"
				pass

func _on_PA_area_entered(area):
	if area.name == "BA":
		player.dead = true
		


func _on_StorePosTimer_timeout():
	var dup = $AnimatedSprite.duplicate()
	#dup.owner = get_parent()
	
	get_parent().add_child_below_node(player, dup)
	dup.stop()
	dup.global_position = global_position


func _on_AnimatedSprite_animation_finished():
	if clipping:
		clipping = false
