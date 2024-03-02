extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var killing = false

var player

# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_parent().get_parent().get_node("Player")
	$StartKillingTimer.start()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D_area_entered(area):
	if area.name == "PA" and !player.draining_pressing and killing:
		player.dead = true


func _on_StartKillingTimer_timeout():
	killing = true
