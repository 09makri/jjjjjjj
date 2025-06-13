extends KinematicBody2D


onready var timer = $shoottime
onready var mussle = $Position2D
var spinbullet = load("res://roundspinnbullet.tscn")
var bullet_speed = 2000
var canShoot = false
var notdead = true

# Called when the node enters the scene tree for the first time.
func _ready():
	notdead = true


# warning-ignore:unused_argument
func _physics_process(delta):
	pass
#	mussle.rotation_degrees = Global.player.position

func shoot():
	if notdead == true:
		if canShoot == true:
			var bull = spinbullet.instance()
			get_tree().get_root().add_child(bull)
			bull.global_position = mussle.global_position
			var dir = (Global.player.global_position - global_position).normalized()
			bull.global_rotation = dir.angle() + PI / 2.0
			bull.direction = dir
			timer.start()


func _on_shoottime_timeout():
	shoot()


func _on_Area2D_body_entered(body):
	if body.name == "player":
		canShoot = true
		
