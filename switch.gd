extends Area2D

signal is_working()

var is_broken = true

func _ready():
	$anim.play("off")
	$sparkles.emitting = false

func _on_switch_body_entered( body ):
	if body.has_method("fixes_machine") and is_broken:
		is_broken = false
		body.fixes_machine()
		$anim.play("on")
		$sparkles.emitting = true
		$sound.playing = true
		emit_signal("is_working")
