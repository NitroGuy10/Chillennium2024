extends Timer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	get_parent().position.x += (randf() * 5) - 2.5
	get_parent().position.y += (randf() * 5) - 2.5


func _on_KillTimer_timeout():
	get_parent().queue_free()


func _on_SpawnTimer_timeout():
	get_parent().visible = true
