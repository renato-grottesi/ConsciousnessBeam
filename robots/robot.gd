extends KinematicBody2D

signal lost_consciousness()
signal on_focus()

export(bool) var has_focus = false

const MAX_SPEED = 128.0

var vel = Vector2()
var teleport_pending = 0

func _ready():
	pass

func _input(event):
	if has_focus and teleport_pending==0:
		if event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
			$beam.cast_to = event.position - (position + $beam.position)
			teleport_pending = 2

func _physics_process(delta):
	vel = move_and_slide(vel, Vector2(0, -1))
	if has_focus:
		var speed = 0.0
		if Input.is_action_pressed("ui_right"):
			speed += 1.0
		if Input.is_action_pressed("ui_left"):
			speed -= 1.0
		vel.x = lerp(vel.x, speed*MAX_SPEED, 0.1)
		if teleport_pending > 0:
			teleport_pending -= 1
			if $beam.is_colliding():
				var coll = $beam.get_collider()
				$beam.cast_to = Vector2(0.1, 0.1)
				if coll.has_method("receive_consciousness"):
					coll.receive_consciousness(self)
					$beam_hit_green.global_position = $beam.get_collision_point()
					$beam_hit_green.emitting = true
					$beam_hit_green.restart()
				else:
					emit_signal("lost_consciousness")
					$beam_hit_red.global_position = $beam.get_collision_point()
					$beam_hit_red.emitting = true
					$beam_hit_red.restart()
	
	vel.y  += 981 * delta
	
	if vel.x > 8.0: 
		$animations.flip_h = false
		if ! $wheels_sound.playing:
			$wheels_sound.play()
	if vel.x < -8.0: 
		$animations.flip_h = true
		if ! $wheels_sound.playing:
			$wheels_sound.play()
	
	if $push_r.is_colliding():
		var coll = $push_r.get_collider()
		if coll!=null and coll.has_method("robot_push"):
			coll.robot_push(Vector2(8.0, 0.0))
	if $push_l.is_colliding():
		var coll = $push_l.get_collider()
		if coll!=null and coll.has_method("robot_push"):
			coll.robot_push(Vector2(-8.0, 0.0))

func receive_consciousness(from):
	has_focus = true
	from.has_focus = false
	emit_signal("on_focus", self)
