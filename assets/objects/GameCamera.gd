extends Node2D

export var max_ram = 10000

const screenWidth = 1300
const screenHeight = 800
const followBuffer = 200

const lerpSpeed = 0.8


# Called when the node enters the scene tree for the first time.
func _ready():
	$Meter.max_ram = max_ram


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("ui_select"):
		$Shake.position.x = randf() * 10
		$Shake.position.y = randf() * 10
	
	var blend = 1 - pow(0.2, lerpSpeed * delta)
	position = lerp(position, get_parent().get_node("Player/KinematicBody2D").position, blend)

	position.x = clamp(position.x, get_parent().get_node("Player/KinematicBody2D").position.x - (screenWidth / 2) + followBuffer, get_parent().get_node("Player/KinematicBody2D").position.x + (screenWidth / 2) - followBuffer)
	position.y = clamp(position.y, get_parent().get_node("Player/KinematicBody2D").position.y - (screenHeight / 2) + followBuffer, get_parent().get_node("Player/KinematicBody2D").position.y + (screenHeight / 2) - followBuffer)
