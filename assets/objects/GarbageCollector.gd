extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var introduceSelf = false


# Called when the node enters the scene tree for the first time.
func _ready():
	$LeakCheckpoint.is_last = true
	$LeakCheckpoint.player = get_parent().get_node("Player")
	
	$HowdySprite.visible = introduceSelf


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
