extends RigidBody2D

func _ready():
	pass

func fixes_machine():
	queue_free()

func robot_push(push):
	apply_impulse(Vector2(0.01, 0.01), push)