extends "res://scenes/level_base.gd"

var switch_on = false

func _physics_process(delta):
	if switch_on:
		$platform.position.y -= delta * 64.0
		if $platform.position.y < 64:
			$platform.position.y = 380

func _on_switch_is_working():
	switch_on = true
