extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var next_tscn = "res://assets/levels/test_level.tscn"
var next_scene

# Called when the node enters the scene tree for the first time.
func _ready():
	next_scene = load(next_tscn)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	rotate(6 * delta)


func _on_DispSizeTimer_timeout():
	$GlitchFX.material.set_shader_param("dispSize", randf() * 1.5)


func _on_Area2D_area_entered(area):
	if area.name == "PA":
		get_parent().get_node("Player/PKB").winning = true
		$NextLevelTimer.start()
		get_parent().get_node("GameCamera").fading_to_black = true


func _on_NextLevelTimer_timeout():
	var new_level = next_scene.instance()
	get_parent().get_parent().add_child(new_level)
	get_parent().queue_free()
