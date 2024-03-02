extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var max_ram = 10000
var ram_used = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func drain(speed, delta):
	ram_used += speed * delta


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Fill.scale.y = ram_used / max_ram
	
	if ram_used > max_ram:
		$Fill.scale.x = 500
