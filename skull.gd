extends KinematicBody2D

onready var anim = $AnimatedSprite
onready var deathtimer = $deathTimer
onready var stoptimer = $stoppTimer
onready var hitsound = $hitsound
#onready var getplayer = get_node("res://player.tscn")

export var xrangex = 32
export var xrangey = 456
export var yrangex = 32
export var yrangey = 192

var health = 2
var dead = false
var target = null
const SPEED = 80
var can_fly = true
var velocity
var path: Array = []	# Contains destination positions
var levelNavigation: Navigation2D = null
var player = null

# warning-ignore:unused_signal
signal hitsound

const blood = preload("res://blood.tscn")
const dashfx = preload("res://dash fx.tscn")
const deadsound = preload("res://deadsound.tscn")

#var angle = global_position.angle_to_point(Global.player.global_position)
var angle
func _ready():
#	yield(get_tree(), "idle_frame")
	var tree = get_tree()
	if tree.has_group("LevelNavigation"):
		levelNavigation = tree.get_nodes_in_group("LevelNavigation")[0]
	if tree.has_group("Player"):
		player = tree.get_nodes_in_group("Player")[0]
#	health = 2
	add_to_group("enemy")
#	randomize()
#	var x = rand_range(xrangex, xrangey)
#	var y = rand_range(yrangex, yrangey)
#	position = Vector2(x, y)
#	Global.scene_enemy_amount += 1
#	add_to_group("enemie")
#	$collide/CollisionShape2D.disabled = false
#	can_fly = true
#	anim.show()
#	anim.self_modulate = Color(255,255,255)
#	$Light2D.enabled = false
#	$Light2D2.enabled = false
	anim.play("fly")

func _physics_process(_delta):
	if player and levelNavigation:
		generate_path()
		navigate()
	if Global.playerdead == true:
		can_fly = false
	if health <= 0:
		dead = true
		dead2()
#		yield(get_tree().create_timer(0.2), "timeout")
#		dead()
#	if (Global.player.position.x > 0):
	if target:
		if can_fly == true:
#			velocity = global_position.direction_to(target.global_position)
# warning-ignore:return_value_discarded
			velocity = move_and_slide(velocity)
			
#	var direction_to_player = to_local(getplayer.global_position)
#	if (to_local(Global.player.global_position).x < 0):
#		scale.x = 1
#	else:
#		scale.x = -1
#	if velocity.x <= 0:
#		scale.x = 1
#	elif velocity.x > 0:
#		scale.x = -1
#	if sign(velocity.x) == 1:
#		anim.set_flip_v(false)
#	else:
#		anim.set_flip_v(true)

func navigate():	# Define the next position to go to
	if path.size() > 0:
		velocity = global_position.direction_to(path[1]) * SPEED
		
		# If reached the destination, remove this point from path array
		if global_position == path[0]:
			path.pop_front()
		
		if velocity.x <= 0:
			scale.x = 1
		elif velocity.x > 0:
			scale.x = -1

func generate_path():	# It's obvious
	if levelNavigation != null and player != null:
		path = levelNavigation.get_simple_path(global_position, player.global_position, false)

func _on_Area2D_body_entered(body):
#	print(body.name)
	if body.name == "player":
		target = body
		$Light2D.enabled = true
		$Light2D2.enabled = true

# warning-ignore:unused_argument
func _on_Area2D_body_exited(body):
	pass
#	if body.name == "player":
#		target = null

# warning-ignore:function_conflicts_variable
func dead():
#	Global.scene_enemy_amount -= 1
	call_deferred("remove_from_group", "enemie")
	can_fly = false
	anim.hide()
	$Light2D.enabled = false
	$Light2D2.enabled = false
#	$collide/CollisionShape2D.call_deferred("disabled", true)
	$collide/CollisionShape2D.disabled = true
	deathtimer.start()
#	yield(get_tree().create_timer(4), "timeout")
	
#	call_deferred("free")
		

func dead2():
	var deadsoundinst = deadsound.instance()
	get_parent().add_child(deadsoundinst)
	Global.score += 1
	can_fly = false
	$collide/CollisionShape2D.disabled = true
	$Light2D.enabled = false
	$Light2D2.enabled = false
	anim.hide()
#	yield (hitsound, "finished")
#	yield(get_tree().create_timer(0.1), "timeout")
	queue_free()

func _on_collide_body_entered(body):
	if body.name == "player":
		var dashinst = dashfx.instance()
		get_tree().current_scene.add_child(dashinst)
		dashinst.global_position = global_position
		dashinst.rotation = global_position.angle_to_point(Global.player.global_position)
		Global.player.hit(1)
#	if body.name == "TileMap3":
#		$Light2D.enabled = false
#		$Light2D2.enabled = false
#		anim.modulate = Color(71,71,71)
	if body.name == "bullet":
		if body.active == true:
			hit()

func hit():
	#		if health <= 1:
	#			dead()
	#		if Global.longertimeshoot == true:
	#			emit_signal("hitsound")
					
	hitsound.play()
	get_parent().get_node("ScreenShake").screen_shake(0.3, 3, 10)
	can_fly = false
	health -= Global.attackpwr
	anim.play("hit")
	var blood_instance = blood.instance()
	get_tree().current_scene.add_child(blood_instance)
	blood_instance.global_position = global_position
	blood_instance.rotation = global_position.angle_to_point(Global.player.global_position)
	if dead == false:
#		yield(get_tree().create_timer(0.2), "timeout")
		stoptimer.start()
	#			anim.play("fly")
	#			can_fly = true 
	#			Global.target = self

func _on_collide_body_exited(body):
	if body.name == "TileMap3":
#		anim.modulate = Color(255,255,255)
		$Light2D.enabled = true
		$Light2D2.enabled = true


func _on_deathTimer_timeout():
	call_deferred("free")


func _on_stoppTimer_timeout():
	anim.play("fly")
	can_fly = true 
