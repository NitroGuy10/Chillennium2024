extends Node2D

export var max_ram = 10000
export var clamping = true

const screenWidth = 1300
const screenHeight = 800
const followBuffer = 200

const lerpSpeed = 0.9

var drain_speed_lerp = 999
var force_arbitrary_drain_speed_lerp = false
var death_cycle = 0
var player
var fading_to_black = false

export var background_number = "1"
export var level_tscn = "res://assets/levels/test_level.tscn"
var level_scene


# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_parent().get_node("Player")
	$Meter.max_ram = max_ram
	level_scene = load(level_tscn)
#	$Blinking.visible = true
	$BlackScreen.color.a = 3
	
	for i in range(1, 4):
#		$Background/bg1.spe = 
		var background = get_node("Background/bg" + str(i))
		background.animation = background_number


func _physics_process(delta):
	
	var draining_speed = player.draining_speed()
	var blend = 1 - pow(0.1, 0.9 * delta)
	if !force_arbitrary_drain_speed_lerp:
		drain_speed_lerp = lerp(drain_speed_lerp, draining_speed, blend)
	
	var ram_percent = $Meter.ram_used / $Meter.max_ram
	
	if player.dead:
		drain_speed_lerp += 50000 * delta
	
	if fading_to_black:
		$BlackScreen.color.a = min(5, $BlackScreen.color.a + (10 * delta))
	else:
		$BlackScreen.color.a = max(0, $BlackScreen.color.a - (10 * delta))
	
	if player.draining():
		$Shake.position.x = randf() * (draining_speed / 100)   
		$Shake.position.y = randf() * (draining_speed / 100)
	
	$Meter/Fill/FillSprite2.modulate = Color(1 - max(0, drain_speed_lerp - 500) / 500, 1 - max(0, drain_speed_lerp - 300) / 300, 1)
	$Meter/Fill/Fillness.modulate = Color(0.8 + max(0, drain_speed_lerp - 500) / 500, 0.8 + max(0, drain_speed_lerp - 500) / 500, 0.8 + max(0, drain_speed_lerp - 500) / 500)
	$Meter/Fill/CPUParticles2D.emitting = drain_speed_lerp > 100
	
	$GlitchFX.material.set_shader_param("abberationAmtX", 0.000 + (0.001 * ram_percent) + (0.00001 * drain_speed_lerp))
	$GlitchFX.material.set_shader_param("abberationAmtY", 0.000 + (0.001 * ram_percent) + (0.00001 * drain_speed_lerp))
	$GlitchFX.material.set_shader_param("dispAmt", (0.003 * ram_percent) + (0.00001 * drain_speed_lerp))

	if player.dead and $DeathTimer.is_stopped():
		$DeathTimer.start()
		death_cycle = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	var blend = 1 - pow(0.1, lerpSpeed * delta)
	position = lerp(position, player.get_node("PKB").global_position, blend)

	if clamping:
		position.x = clamp(position.x, player.get_node("PKB").global_position.x - (screenWidth / 2) + followBuffer, player.get_node("PKB").global_position.x + (screenWidth / 2) - followBuffer)
		position.y = clamp(position.y, player.get_node("PKB").global_position.y - (screenHeight / 2) + followBuffer, player.get_node("PKB").global_position.y + (screenHeight / 2) - followBuffer)

	var blend2 = 1 - pow(0.1, 0.9 * delta)
	var background_target_pos = player.get_node("PKB").global_position / -10
	$Background.position = lerp($Background.position, background_target_pos, blend2)



func _on_DispSizeTimer_timeout():
	$GlitchFX.material.set_shader_param("dispSize", randf() * 1.5)


func _on_BlackBlinkTimer_timeout():
	$Blinking/BlinkBlackScreen.visible = !$Blinking/BlinkBlackScreen.visible


func _on_DeathTimer_timeout():
	if death_cycle == 2:
		fading_to_black = true
#		$Blinking.visible = true
		pass
	elif death_cycle == 3:
#		$BlackScreen.visible = true
		pass
	elif death_cycle == 4:
		var new_level = level_scene.instance()
		get_parent().get_parent().add_child(new_level)
		get_parent().queue_free()
	death_cycle += 1


func _on_StartTimer_timeout():
#	$Blinking.visible = false
	pass
