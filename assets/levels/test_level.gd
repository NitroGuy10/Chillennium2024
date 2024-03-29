extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

const screenWidth = 1300
const screenHeight = 800
const followBuffer = 200

const lerpSpeed = 0.8;


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("ui_select"):
		$Shake.position.x = randf() * 10
		$Shake.position.y = randf() * 10
	
	var blend = 1 - pow(0.2, lerpSpeed * delta)
	$Shake/Camera2D.position = lerp($Shake/Camera2D.position, $Player/KinematicBody2D.position, blend)

	$Shake/Camera2D.position.x = clamp($Shake/Camera2D.position.x, $Player/KinematicBody2D.position.x - (screenWidth / 2) + followBuffer, $Player/KinematicBody2D.position.x + (screenWidth / 2) - followBuffer)
	$Shake/Camera2D.position.y = clamp($Shake/Camera2D.position.y, $Player/KinematicBody2D.position.y - (screenHeight / 2) + followBuffer, $Player/KinematicBody2D.position.y + (screenHeight / 2) - followBuffer)
