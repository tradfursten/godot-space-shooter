extends KinematicBody

const MAX_SPEED = 200
const ACCELERATION = 10

var inputVector = Vector3()
var vel = Vector3()

onready var guns = [$gun, $gun2]
onready var main = get_tree().current_scene

onready var Bullet = load("res://Bullet.tscn")

var cooldown = 0
var COOLDOWN = 8

func _physics_process(delta: float) -> void:
	inputVector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	inputVector.y = Input.get_action_strength("ui_up") - Input.get_action_strength("ui_down")
	inputVector = inputVector.normalized()
	
	vel.x = move_toward(inputVector.x, inputVector.x * MAX_SPEED, ACCELERATION)
	vel.y = move_toward(inputVector.y, inputVector.y * MAX_SPEED, ACCELERATION)
	
	rotation_degrees.z = vel.x * -2
	rotation_degrees.x = vel.y / 2
	rotation_degrees.y = -vel.x / 2
	
	move_and_slide(vel)
	
	transform.origin.x = clamp(transform.origin.x, -12, 12)
	transform.origin.y = clamp(transform.origin.y, -8, 8)
	
	if Input.is_action_pressed("ui_accept") and cooldown <= 0:
		cooldown = COOLDOWN * delta
		for g in guns:
			var bullet = Bullet.instance()
			main.add_child(bullet)
			bullet.transform = g.global_transform
			bullet.vel = bullet.transform.basis.z * -600
			
	if cooldown > 0:
		cooldown -= delta
