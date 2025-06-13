extends KinematicBody2D

#var explo = load("res://explosion.tscn")
const explo = preload("res://explosion.tscn")

onready var anim = $AnimatedSprite
onready var blowuptimer = $blowup

var vel = Vector2(0, 0)
var can_move = false
var grav = 1800
var max_grav = 3000
var can_jump = true
var react_time = 300
var dir = 0
var next_dir = 0
var next_dir_time = 0

func _ready():
	pass

func _process(delta):
	if can_move == true:
		if Global.player.position.x < position.x and next_dir != -1:
			next_dir = -1
			next_dir_time = OS.get_ticks_msec() + react_time
		elif Global.player.position.x > position.x and next_dir != 1:
			next_dir = 1
			next_dir_time = OS.get_ticks_msec() + react_time
		elif Global.player.position.x == position.x and next_dir != 0:
			next_dir = 0
			next_dir_time = OS.get_ticks_msec() + react_time
		
		if OS.get_ticks_msec() > next_dir_time:
			dir = next_dir
		
		vel.x = dir * 100
	
	if can_jump == true:
		vel.y += grav * delta
		if vel.y > max_grav:
				vel.y = max_grav
	
#	if is_on_floor() and vel.y > 0:
#		vel.y = 0
		
	vel = move_and_slide(vel, Vector2(0, -1))
		
		
	
func blowup():
#	vel.y = -700
#	if vel.y == -700:
#		grav = 0
#		vel.y = -700
#		can_jump = false
	can_move = false
	anim.play("active")
	$delete.start()

func _on_blowup_timeout():
	blowup()


func _on_delete_timeout():
	var exploinst = explo.instance()
	get_tree().current_scene.add_child(exploinst)
	exploinst.global_position = global_position
#	add_child(exploinst)
	queue_free()


func _on_seecoll_body_entered(body):
	if body.name == "player":
		can_move = true
		blowuptimer.start()
		anim.play("run")
