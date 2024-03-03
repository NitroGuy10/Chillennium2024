extends ColorRect

var size = 0.0
var up = true

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _process(delta):
	pass

func _physics_process(delta):
	pass

#func _on_Timer_timeout():
##	if size < 0.53:
##		up = true
##	elif size > 1.0:
##		up = false
##
##	if up:
##		size += 0.01
##	else:
##		size -= 0.01
#	if size > 1.0:
#		size = 0.53
#	size += 0.05
#	self.material.set_shader_param("dispSize", size)
