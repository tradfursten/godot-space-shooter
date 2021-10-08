extends KinematicBody

var speed = rand_range(20, 70)

func _physics_process(delta: float) -> void:
	move_and_slide(Vector3(0,0,speed))
	if transform.origin.z > 10:
		queue_free()
