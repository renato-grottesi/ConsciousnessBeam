extends Area2D

signal is_working()

func _ready():
	$anim.play("off")
	$smoke.emitting = false

func _on_machine_body_entered( body ):
	if body.has_method("fixes_machine"):
		body.fixes_machine()
		$anim.play("on")
		$smoke.emitting = true
		$activation.interpolate_property($sound, "volume_db", -24, 0.0, 3, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		$activation.start()
		$sound.playing = true

func _on_activation_tween_completed( object, key ):
	emit_signal("is_working")
