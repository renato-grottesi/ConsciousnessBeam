extends Node2D

onready var level_1_instance = preload("res://scenes/level_1.tscn")

func _ready():
	$gui/play.grab_focus()
	pass

func _process(delta):
	pass

func _on_quit_pressed():
	get_tree().quit()


func _on_play_pressed():
	var level_1 = level_1_instance.instance()
	get_tree().get_root().add_child(level_1)
	get_tree().get_root().remove_child(self)
	queue_free()

func _on_help_pressed():
	$gui/fg_dialog/title.text = "Help"
	$gui/fg_dialog/text.text = "A=left\nD=right\nClick a visible robot to transmit the consciousness."
	$gui/fg_dialog.visible = true
	$gui/close.visible = true
	$gui/close.grab_focus()

func _on_credits_pressed():
	$gui/fg_dialog/title.text = "Credits"
	$gui/fg_dialog/text.text = "Game design, programming and art from Renato Grottesi\n\nCCFont: https://fontlibrary.org/en/font/mr-pixel"
	$gui/fg_dialog.visible = true
	$gui/close.visible = true
	$gui/close.grab_focus()

func _on_close_pressed():
	$gui/close.visible = false
	$gui/fg_dialog.visible = false
	$gui/play.grab_focus()