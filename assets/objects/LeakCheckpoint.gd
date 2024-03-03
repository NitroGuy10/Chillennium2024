extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var connected = false
var is_last = false

var player


# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_parent().get_node("Player")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_PylonArea_area_entered(area):
	if area.name == "PA" and player.connecting_leak != null and !connected:
		var leak_pos = player.connecting_leak.global_position
		var point_pos = global_position - leak_pos
		player.connecting_leak.get_node("Line2D").add_point(point_pos, -2)
		connected = true
		$LinePositionFixTimer.start()


func _on_LinePositionFixTimer_timeout():
	var leak_pos = player.connecting_leak.global_position
	var point_pos = global_position - leak_pos
	player.connecting_leak.get_node("Line2D").points[-2] = point_pos
	player.connecting_leak.block_segment()
	
	if is_last:
		player.connecting_leak.is_connecting = false
		player.connecting_leak.success = true
		player.connecting_leak.get_node("Line2D").remove_point(-1)
		player.connecting_leak = null
