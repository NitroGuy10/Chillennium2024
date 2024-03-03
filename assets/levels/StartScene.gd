extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var level0 = preload("res://assets/levels/level_0.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_AnimatedSprite_animation_finished():
	get_parent().add_child(level0.instance())
	queue_free()
