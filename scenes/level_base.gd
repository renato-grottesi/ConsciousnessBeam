extends Node2D

onready var main_menu_instance = preload("res://scenes/main_menu.tscn")

export(String) var current_level_path
export(String) var next_level_path = "res://scenes/main_menu.tscn"

var robot_soul

func _ready():
	robot_soul = $robot
	$hud/dialog.visible = false
	pass

func _process(delta):
	$soul.position = robot_soul.position
	$soul.position.y -= 20

func _on_robots_lost_consciousness():
	$game_over_tween.interpolate_property($camera, "offset", Vector2(12,12), Vector2(), 1, Tween.TRANS_ELASTIC, Tween.EASE_OUT)
	$game_over_tween.start()

func _on_robot_focus(robot):
	$soul_tween.interpolate_property($soul_trail, "position", $soul.position, robot.position, 0.25, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$soul_tween.interpolate_property($camera, "rotation_degrees", 9, 0, 1.0, Tween.TRANS_ELASTIC, Tween.EASE_OUT)
	$soul_tween.start()
	$soul_sound.stop()
	$soul_sound.play()
	$soul_trail.emitting = true
	robot_soul = robot

func _on_retry_pressed():
	get_tree().set_pause(false)
	var curr_level_instance = load(current_level_path).instance()
	get_tree().get_root().add_child(curr_level_instance)
	get_tree().get_root().remove_child(self)
	queue_free()

func _on_quit_pressed():
	get_tree().set_pause(false)
	var main_menu = main_menu_instance.instance()
	get_tree().get_root().add_child(main_menu)
	get_tree().get_root().remove_child(self)
	queue_free()

func _on_soul_tween_completed( object, key ):
	$soul_trail.emitting = false

func _on_machine_is_working():
	var next_level_instance = load(next_level_path).instance()
	get_tree().get_root().add_child(next_level_instance)
	get_tree().get_root().remove_child(self)
	queue_free()

func _on_game_over_tween_completed( object, key ):
	$hud/dialog.visible = true
	$hud/dialog/retry.grab_focus()
	get_tree().set_pause(true)
