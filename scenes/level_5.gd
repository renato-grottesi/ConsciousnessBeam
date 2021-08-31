extends "res://scenes/level_base.gd"

var switch_v_on = false
var switch_h_on = false
var switch_h_r = true

func _physics_process(delta):
	if switch_v_on:
		$platform_v.position.y -= delta * 64.0
		if $platform_v.position.y < 220:
			$platform_v.position.y = 380
	
	if switch_h_on:
		if switch_h_r:
			$platform_h.position.x += delta * 16.0
			if $platform_h.position.x > 580:
				switch_h_r = false
		else:
			$platform_h.position.x -= delta * 16.0
			if $platform_h.position.x < 410:
				switch_h_r = true

func _on_switch_l_is_working():
	switch_v_on = true

func _on_switch_r_is_working():
	switch_h_on = true
