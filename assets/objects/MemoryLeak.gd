extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var is_connecting = false


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_connecting:
		var player_pos = get_parent().get_node("Player/PKB").global_position
		var point_pos = player_pos - position
		$Line2D.points[1] = point_pos

#func _physics_process(delta):
#	for body in $LeakArea.get_overlapping_bodies():
#		if "PKB" == body.name:
#			print("asfasdf")



func _on_LeakArea_area_entered(area):
	if area.name == "PA":
		get_parent().get_node("Player").draining_in_leak_area = true


func _on_LeakArea_area_exited(area):
	if area.name == "PA":
		get_parent().get_node("Player").draining_in_leak_area = false



func _on_PylonArea_area_entered(area):
	if area.name == "PA":
		is_connecting = true
		
	
