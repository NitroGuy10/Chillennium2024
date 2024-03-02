extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


var draining_pressing = false
var draining_in_leak_area = false

var ram_pressing_speed = 1000
var ram_in_leak_area_speed = 1000

var meter

# Called when the node enters the scene tree for the first time.
func _ready():
	meter = get_parent().get_node("GameCamera/Meter")
	
	
func draining():
	return draining_pressing or draining_in_leak_area


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_select"):
		draining_pressing = true
	elif Input.is_action_just_released("ui_select"):
		draining_pressing = false
	
	if draining_pressing:
		meter.drain(ram_pressing_speed, delta)
	if draining_in_leak_area:
		meter.drain(ram_in_leak_area_speed, delta)
