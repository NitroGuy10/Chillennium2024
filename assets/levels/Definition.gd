extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var ready_to_go = false


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if ready_to_go and Input.is_action_just_pressed("ui_select"):
		get_parent().get_node("DeathTimer").start()
		get_parent().get_parent().get_parent().force_hang = false


func _on_Timer_timeout():
	visible = true
	ready_to_go = true
