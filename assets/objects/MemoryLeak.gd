extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var is_connecting = false
var success = false
var player

var wire_kill_zone = preload("res://assets/objects/WireKillZone.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_parent().get_node("Player")
	pass # Replace with function body.

func segment_length():
	return sqrt(pow($Line2D.points[-2].x - $Line2D.points[-1].x, 2) +
		pow($Line2D.points[-2].y - $Line2D.points[-1].y, 2))

func prev_segment_length():
	return sqrt(pow($Line2D.points[-3].x - $Line2D.points[-2].x, 2) +
		pow($Line2D.points[-3].y - $Line2D.points[-2].y, 2))

func block_segment():
	var kill_zone = wire_kill_zone.instance()
	kill_zone.position = $Line2D.points[-3]
	
	var x_dist = $Line2D.points[-2].x - $Line2D.points[-3].x
	var y_dist = $Line2D.points[-2].y - $Line2D.points[-3].y
	kill_zone.rotation = atan2(y_dist, x_dist) + (PI / 2)
	
	kill_zone.scale.y = prev_segment_length() / 4
	add_child(kill_zone)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_connecting:
		var player_pos = player.get_node("PKB").global_position
		var point_pos = player_pos - $PylonArea/Sprite.global_position
		point_pos.y -= 100
		$Line2D.points[-1] = point_pos
	
	$LeakArea.monitoring = !success
	$PylonArea.monitoring = !success
	$LeakArea.visible = !success
	$Line2D.visible = success or is_connecting
	
	if success:
		$Line2D.texture = load("res://assets/spriteframes/animated_wire.tres")

#func _physics_process(delta):
#	for body in $LeakArea.get_overlapping_bodies():
#		if "PKB" == body.name:
#			print("asfasdf")



func _on_LeakArea_area_entered(area):
	if area.name == "PA":
		player.draining_in_leak_area = true


func _on_LeakArea_area_exited(area):
	if area.name == "PA":
		player.draining_in_leak_area = false



func _on_PylonArea_area_entered(area):
	if area.name == "PA" and player.connecting_leak == null:
		is_connecting = true
		player.connecting_leak = self
		$Line2D.visible = true
		
	
