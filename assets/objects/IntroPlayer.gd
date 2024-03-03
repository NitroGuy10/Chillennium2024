extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


var draining_pressing = false
var draining_in_leak_area = false

var ram_pressing_speed = 1000
var ram_in_leak_area_speed = 10000

var meter
var connecting_leak = null

var dead = false
var stopping = false

# Called when the node enters the scene tree for the first time.
func _ready():
	meter = get_parent().get_node("GameCamera/Meter")
	
	
func draining():
	return draining_speed() != 0

func draining_speed():
	var drain_speed = 0
	if draining_pressing:
		drain_speed += ram_pressing_speed
	if draining_in_leak_area:
		drain_speed += ram_in_leak_area_speed
		dead = true
	if connecting_leak != null:
		drain_speed += connecting_leak.segment_length()
	return drain_speed


#func _physics_process(delta):
#	if Input.is_action_pressed("restart"):
#		meter.ram_used += 100000 * delta
#
#	if Input.is_action_just_pressed("ui_select"):
#		draining_pressing = true
#	elif Input.is_action_just_released("ui_select"):
#		draining_pressing = false
#
#	meter.drain(draining_speed(), delta)
#	if (meter.ram_used > meter.max_ram):
#		dead = true
#
	
#	$PKB/Dead.visible = dead

func _process(delta):
	if stopping:
		get_parent().get_node("GameCamera").drain_speed_lerp = min(10000, get_parent().get_node("GameCamera").drain_speed_lerp + 1000 * delta)


func _on_Timer_timeout():
	$PKB.hanging = true
	get_parent().get_node("GameCamera").force_arbitrary_drain_speed_lerp = true
	stopping = true
