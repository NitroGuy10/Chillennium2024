extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var glitchyness = 3
var gravityscale = 90.0

var characterVelocity = -60.0
var textVelocity = 60.0

var animatingCharacter = true
var animatingTitle = true
var starting = false

var startButtonBlinks = 0
var fadingToBlack = 0

var start_scene = preload("res://assets/levels/StartScene.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if fadingToBlack >= 1:
		$BlackScreen.color.a = min(5, $BlackScreen.color.a + (10 * delta))

func _physics_process(delta):
	if not starting and (animatingCharacter and characterVelocity > 0 and $TitleCharacterSprite.global_position.y > 280):
		animatingCharacter = false
	
	if animatingCharacter:
		characterVelocity += 0.5 * delta * gravityscale
		$TitleCharacterSprite.position.y += characterVelocity
		characterVelocity += 0.5 * delta * gravityscale
	else:
		$TitleCharacterSprite.global_position.y = 320
	
	
	
	if not starting and (animatingTitle and textVelocity < 0 and $TitleSprite.global_position.y < 320):
		animatingTitle = false
		$Button/StartButtonTimer.start()
	
	if animatingTitle:
		textVelocity -= 0.5 * delta * gravityscale
		$TitleSprite.position.y += textVelocity
		textVelocity -= 0.5 * delta * gravityscale
	else:
		$TitleSprite.global_position.y = 280
	
	
	$GlitchFX.material.set_shader_param("abberationAmtX", 0.000 + (0.001 * glitchyness))
	$GlitchFX.material.set_shader_param("abberationAmtY", 0.000 + (0.001 * glitchyness))
	$GlitchFX.material.set_shader_param("dispAmt", (0.003 * glitchyness))
	
#	$BackgroundSprite.offset.x = (randf() * 4) - 2
#	$BackgroundSprite.offset.y = (randf() * 4) - 2

func _on_DispSizeTimer_timeout():
	$GlitchFX.material.set_shader_param("dispSize", randf() * 1.5)


func _on_Button_pressed():
	$Button.queue_free()
	starting = true
	animatingCharacter = true
	animatingTitle = true
	characterVelocity = -15
	textVelocity = 15
	$BlackScreen/FadeToBlackTimer.start()


func _on_StartButtonTimer_timeout():
	startButtonBlinks += 1
	if startButtonBlinks > 9:
		$Button.visible = true
		$Button/StartButtonTimer.stop()
		$Button.disabled = false
	elif startButtonBlinks > 5:
		$Button.visible = !$Button.visible
	


func _on_FadeToBlackTimer_timeout():
	$BlackScreen.visible = true
	fadingToBlack += 1
	
	if fadingToBlack == 2:
		get_parent().get_node("Music").play()
		get_parent().get_node("GlitchMusic").play()
		get_parent().add_child(start_scene.instance())
		queue_free()
