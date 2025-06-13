extends Node2D

# warning-ignore:unused_signal
signal hitsound

#const bullet_scene = preload("res://bulethell/Bullethell.tscn")
const bullet_scene = preload("res://roundspinnbullethell.tscn")
onready var shoot_timer = $ShootTimer
onready var rotater = $Rotater
onready var grouptimer = $groupTimer
onready var anim = $AnimatedSprite
onready var positiontimer = $PositionTimer
onready var hitsound = $hitsound

const blood = preload("res://blood.tscn")
const dashfx = preload("res://dash fx.tscn")
const pooffx = preload("res://poofFX.tscn")

var can_shoot = true
var newpos : Vector2
var randtime
var notdead = true

export var xrangex = 32
export var xrangey = 456
export var yrangex = 32
export var yrangey = 192


#const grouptimerwait = 0.2
var rotate_speed = 30
var shoot_timer_wait_time = 0.6
var spawn_point_count = 2
const radius = 10

func _ready():
	$hit/CollisionShape2D.disabled = false
	spawn_point_count = randi()%5+2
	
	if spawn_point_count == 2 or spawn_point_count == 1:
		shoot_timer_wait_time = rand_range(0.3, 0.5)
	else:
		shoot_timer_wait_time = rand_range(0.8, 1)
	
	rotate_speed = randi()%40+35
#	shoot_timer_wait_time = rand_range(0.3, 1)
	
	
	add_to_group("enemie")
	anim.show()
	anim.play("active")
	var step = 2 * PI / spawn_point_count
	
	for i in range(spawn_point_count):
		var spawn_point = Node2D.new()
		var pos = Vector2(radius, 0).rotated(step * i)
		spawn_point.position = pos
		spawn_point.rotation = pos.angle()
		rotater.add_child(spawn_point)
#	grouptimer.wait_time = grouptimerwait
	shoot_timer.wait_time = shoot_timer_wait_time
	shoot_timer.start()
#	move.play("move")
	new_position()


func new_position():
	if notdead == true:
		var poofinst = pooffx.instance()
		get_tree().current_scene.call_deferred("add_child", poofinst)
#		get_tree().current_scene.add_child(poofinst)
		poofinst.global_position = global_position
		randomize()
		var x = rand_range(xrangex, xrangey)
		var y = rand_range(yrangex, yrangey)
		position = Vector2(x, y)
		positiontimer.start()

func _process(delta):
	var new_rotation = rotater.rotation_degrees + rotate_speed * delta
	rotater.rotation_degrees = fmod(new_rotation, 360)
	randomize()
	randtime = rand_range(4, 10)
	positiontimer.wait_time = round(randtime)

func _on_ShootTimer_timeout() -> void:
	if notdead == true:
		if can_shoot == true:
			for s in rotater.get_children():
				var bullet = bullet_scene.instance()
				get_tree().root.add_child(bullet)
				bullet.position = s.global_position
				bullet.rotation = s.global_rotation
			
#		can_shoot = false
#		grouptimer.start()
			
		


func _on_groupTimer_timeout():
	can_shoot = true


func _on_hit_body_entered(body):
	if body.name == "bullet":
		dead2()
	if body.name == "TileMap" or body.name == "TileMap3":
		new_position()
	if body.name == "player":
		if Global.player.is_dashing == true:
			$hitsound.play()
#			emit_signal("hitsound")
			get_parent().get_node("ScreenShake").screen_shake(0.3, 6, 10)
			var blood_instance = blood.instance()
			get_tree().current_scene.add_child(blood_instance)
			blood_instance.global_position = global_position
			blood_instance.rotation = global_position.angle_to_point(Global.player.global_position)
			var dashinst = dashfx.instance()
			get_tree().current_scene.add_child(dashinst)
			dashinst.global_position = global_position
			dashinst.rotation = global_position.angle_to_point(Global.player.global_position)
#			yield(get_tree().create_timer(0.1), "timeout")
			anim.play("hit")
#			queue_free()
#			dead()
			dead2()
		else:
			Global.player.hit(1)

func dead2():
	notdead = false
#	#	$hit/CollisionShape2D.call_deferred("disabled", true)
#	$hit/CollisionShape2D.disabled = true
	anim.hide()
	yield (hitsound, "finished")
	queue_free()

func dead():
	call_deferred("remove_from_group", "enemie")
#	remove_from_group("enemies")
	$hit/CollisionShape2D.set_deferred("disabled",true)
	notdead = false
	anim.hide()

func _on_PositionTimer_timeout():
	new_position()
