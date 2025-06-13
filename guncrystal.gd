extends KinematicBody2D

signal shooting

onready var timer = $shootTimer
onready var mussle = $muzzle
var spinbullet = load("res://Vbullet.tscn")
var bullet_speed = 1000
var notdead = true


func _ready():
	notdead = true


func shoot():
	if notdead == true:
		emit_signal("shooting")
		randomize()
		timer.wait_time = randi()%4+2
		var bull = spinbullet.instance()
		get_tree().get_root().add_child(bull)
		bull.global_position = mussle.global_position
		var dir = (Global.player.global_position - global_position).normalized()
#		bull.global_rotation = dir.angle() + PI / 2.0
		bull.direction = dir
		timer.start()


func _on_shootTimer_timeout():
	shoot()
