extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var end = false


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if end:
		get_node("Music").volume_db -= 10 * delta
		get_node("GlitchMusic").volume_db -= 10 * delta
	else:
		var hanging = Input.is_action_pressed("ui_select")
		get_node("Music").volume_db = 0 if !hanging else -80
		get_node("GlitchMusic").volume_db = 0 if hanging else -80
