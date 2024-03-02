extends Node2D

export var max_ram = 10000

const screenWidth = 1300
const screenHeight = 800
const followBuffer = 200

const lerpSpeed = 0.9


# Called when the node enters the scene tree for the first time.
func _ready():
	$Meter.max_ram = max_ram


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if get_parent().get_node("Player").draining():
		$Shake.position.x = randf() * 10
		$Shake.position.y = randf() * 10
	
	var blend = 1 - pow(0.1, lerpSpeed * delta)
	position = lerp(position, get_parent().get_node("Player/PKB").global_position, blend)

	position.x = clamp(position.x, get_parent().get_node("Player/PKB").global_position.x - (screenWidth / 2) + followBuffer, get_parent().get_node("Player/PKB").global_position.x + (screenWidth / 2) - followBuffer)
	position.y = clamp(position.y, get_parent().get_node("Player/PKB").global_position.y - (screenHeight / 2) + followBuffer, get_parent().get_node("Player/PKB").global_position.y + (screenHeight / 2) - followBuffer)
