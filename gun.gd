extends KinematicBody2D
const BULLET = preload("res://bullet.tscn")

onready var bullet_spawn = $Position2D
onready var ShootTimer = $pistoltimer

var bullet_speed = 2500
var can_shoot = true
var rotationrandomness
var spread = Global.gunspread

var gun1 = true

func _ready():
	can_shoot = true
	Global.gunspread = 0.08

func _physics_process(_delta):
	shoot1()
	var mouse_pos = get_local_mouse_position()
	rotation += mouse_pos.angle()

func shoot1():
	if gun1 == true:
		if can_shoot == true:
			if Input.is_action_pressed("shoot"):
				var bullet = BULLET.instance()
				get_parent().get_parent().add_child(bullet)
				bullet.position = bullet_spawn.global_position
				get_parent().get_parent().get_node("ScreenShake").screen_shake(0.3, 2, 5)
	#			pistolsound.play()
	#			flashanim.play("flash")
				randomize()
				rotationrandomness = rand_range(-spread,spread)
	#			var look_vec = get_global_mouse_position() - bullet_spawn.global_position
	#			var dir = Vector2(1, 0).rotated(global_rotation)
	#			bullet.direction = dir
	#			bullet.global_rotation = atan2(look_vec.y, look_vec.x)
				bullet.rotation_degrees = rotation_degrees + rotationrandomness
				bullet.apply_impulse(Vector2(), Vector2(bullet_speed, 0).rotated(rotation + rotationrandomness))
				can_shoot = false
				ShootTimer.start()


func _on_pistoltimer_timeout():
	can_shoot = true
	
