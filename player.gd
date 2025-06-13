extends KinematicBody2D

onready var dashgravtime = $Timerdashgrav
onready var anim = $AnimatedSprite
onready var jumptimer = $jumptimer
onready var dashtimer = $dash_timer
#onready var guns = $gun/AnimatedSprite
onready var soulanim = $soulanim
onready var animblink = $AnimationPlayer
onready var invicetimer = $invincebilityTimer
onready var walk = $playerwalk
onready var flute = $flutebody/Flute

var controller = false
var dashspeed = 750
var dashlenght = 0.15

var blood = load("res://bloodplayer.tscn")
const dashfx = preload("res://player dash fx.tscn")
const deadskull = preload("res://deadskull.tscn")

var current_dead = false
var shadowdash = false
var invince = false
var playerhit = false
var squash_speed = 0.01
var dash_deacc
var vspeed
var hspeed
var hit = false
var can_move = true
var vel = Vector2()
var soul = false
var shooshpitch = 1
#var gravity = 8
#var speed = 22
#var stopping_friction = 0.7
#var running_friction = 0.9
#var jumps_left = 1
#var jump_power = 250

#var gravity = 7
#var speed = 21
#var stopping_friction = 0.9
#var running_friction = 0.9
#var jumps_left = 1
#var jump_power = 470

var is_dashing : bool = false
var can_dash : bool = true
var dash_direction : Vector2
#var falldown = true

var gravity = 4.5
var speed = 17
var stopping_friction = 0.9
var running_friction = 0.9
var jumps_left = 1
#var jump_power = 330
var jump_power = 380
var jump_powerx = 350
var jumper = false


var is_jumping = false

var is_dead = false

func _ready():
	current_dead = false
	Global.playerdead = false
	Global.playerhealth = 3
	Global.dashlenght = 0.15
	soulanim.play("off")
	gravity = 4.5
	dashtimer.connect("timeout", self, "dash_timer_timeout")
#	Global.playerhealth = 6
	can_move = true
	is_dead = false
	anim.show()
	Global.player = self

func _exit_tree():
	Global.player = null

func dash_timer_timeout():
	is_dashing = false
	Global.is_dashing = false
	gravity = 4.5
	shadowdash = false

func is_controller():
#	if(Input.get_action_strength("lt_down") > 0.7):
#		controller = true
#	elif(Input.get_action_strength("lt_up") > 0.7):
#		controller = true
#	elif(Input.get_action_strength("lt_right") > 0.7):
#		controller = true
#	elif(Input.get_action_strength("lt_left") > 0.7):
#		controller = true
#	else:
#		controller = false

	if Input.is_action_just_pressed("lt_down"):
		controller = true
	elif Input.is_action_just_pressed("lt_up"):
		controller = true
	elif Input.is_action_just_pressed("lt_right"):
		controller = true
	elif Input.is_action_just_pressed("lt_left"):
		controller = true
	else:
		controller = false

func dash_direction_input():
	var move_dir = Vector2()
#	controller = is_controller()
#	if controller == true:
#		print("controller")
	if controller == true:
		move_dir.x = -Input.get_action_strength("lt_left") + Input.get_action_strength("lt_right")
		move_dir.y = Input.get_action_strength("lt_down") - Input.get_action_strength("lt_up")
	else:
		move_dir.x = -Input.get_action_strength("left") + Input.get_action_strength("right")
		move_dir.y = Input.get_action_strength("down") - Input.get_action_strength("up")
		
	move_dir = move_dir.clamped(1)
	
	if (move_dir == Vector2(0,0)):
		if anim.flip_h:
			move_dir.x = -1
#			Global.playerdir = -1
		else:
			move_dir.x = 1
#			Global.playerdir = 1
	
	return move_dir * dashspeed
#	dash_deacc = move_dir * 
#	return dash_deacc *


# warning-ignore:unused_argument
func handel_dash(var delta):
	if Input.is_action_just_pressed("dash") and can_dash and !is_on_floor():
		soulanim.play("off")
		soul = false
		shadowdash = true
		get_parent().get_node("ScreenShake").screen_shake(0.2, 2, 5)
		shooshpitch = rand_range(0.96, 1.11)
		$shoosh.pitch_scale = shooshpitch
		$shoosh.play()
#		var dashinst = dashfx.instance()
#		dashinst.global_position = $dashfxpoint.position
#		add_child(dashinst)
		dashspeed *= 0.7
		is_dashing = true
		Global.is_dashing = true
		can_dash = false
		dash_direction = dash_direction_input()
		dashtimer.start(Global.dashlenght)
#		if soul == true:
#			soulanim.play("off")
#	if is_dashing == true:
		
#	if is_dashing == true:
#		print("dash")
	
	
func apply_squash_squeeze():
	anim.scale.x = lerp(anim.scale.x,1,squash_speed)
	anim.scale.y = lerp(anim.scale.y,1,squash_speed)

# warning-ignore:unused_argument
func dash_physics(delta):
#	vel.y = vspeed
#	vel.x = hspeedk
	
	if is_dashing == true:
#		print(dash_direction)
		vel = move_and_slide(dash_direction,Vector2.UP)
		vel.y = 0
		vel.x = 0
#	else:
#		vel = move_and_slide(vel,Vector2.UP)
	

func _physics_process(delta):
	if Global.playerdead == true:
		$deadtimer.start()
	if Global.playerhealth <= 0:
		$AnimatedSprite.play("dead")
		dead()
	if Global.timerstreak >= 4:
		$soulanim.play("on")
	else:
		$soulanim.play("off")
#	if vel.x > 0 and is_on_floor():
#		if !walk.playing:
#			walk.play()
#	elif walk.playing:
#		walk.stop()
	is_controller()
#	if Input.is_action_just_pressed("dash"):
##		get_parent().get_node("ScreenShake").screen_shake(0.3, 6, 5)
#		soulanim.play("off")
	soul()
	$Label.text = var2str(dash_direction)
	if is_on_floor():
		can_dash = true
		dashspeed = 750
#	jump()
	dash_physics(delta)
	handel_dash(delta)
	
	if is_jumping && vel.y >= 0:
		is_jumping = false
#	dead()
	if vel.y > 0:
		jumper = true
	else:
		jumper = false
#	hit(0)
	if is_dead == false:
		gravity()
		anim()
		if can_move == true:
#			dash()
			friction()
			run(delta)
			jump()
	var was_on_floor = is_on_floor()
	vel = move_and_slide(vel, Vector2.UP)
	if !is_on_floor() && was_on_floor && !is_jumping:
		jumptimer.start()
	
	
#	if (get_local_mouse_position().x > 0):
#		$AnimatedSprite.set_flip_h(false)
#	else:
#		$AnimatedSprite.set_flip_h(true)
	
#	if (get_local_mouse_position().y > 0):
#		guns.z_index = 0
#		guns.z_index += 1
#	else:
#		guns.z_index = 0
#		guns.z_index -= 1
##
#	if (get_local_mouse_position().x > 0):
#		guns.set_flip_v(false)
#	else:
#		guns.set_flip_v(true)
# warning-ignore:function_conflicts_variable
func hit(amount):
	if invince == false:
		if shadowdash == false:
			Global.playerhealth -= amount
			if amount > 0:
				get_parent().get_node("ScreenShake").screen_shake(0.3, 2, 3)
				$AudioStreamPlayer.playrandom()
				$AudioStreamPlayer2.playrandom()
	#			var blood_instance = blood.instance()
	#			get_tree().current_scene.add_child(blood_instance)
	#			blood_instance.global_position = global_position
	#			blood_instance.rotation = global_position.angle_to_point(Global.target.global_position)
	#			vel = 0
				if current_dead == false:
					get_parent().get_node("ScreenShake").screen_shake(0.7, 3, 3)
				playerhit = true
				can_move = false
				anim.play("hit")
				if Global.playerhealth >= 1:
					yield(get_tree().create_timer(0.4), "timeout")
					anim.play("idle")
					can_move = true
					playerhit = false
					invince = true
					invicetimer.start()
			
		

#func dash():
#	if is_on_floor():
#		can_dash = true
#
#	if Input.is_action_just_pressed("right"):
#		dash_direction = Vector2(1,0)
#	if Input.is_action_just_pressed("left"):
#		dash_direction = Vector2(-1,0)
#	if Input.is_action_just_pressed("right") and Input.is_action_just_pressed("up"):
#		dash_direction = Vector2(1,-1)
#	if Input.is_action_just_pressed("left") and Input.is_action_just_pressed("up"):
#		dash_direction = Vector2(-1,-1)
#	if Input.is_action_just_pressed("up"):
#		dash_direction = Vector2(0,-1)
#
#	if Input.is_action_just_pressed("dash") and can_dash:
#		if dash_direction.y == 0:
#			vel = dash_direction.normalized() * 2200
#		if dash_direction.y == 1 or dash_direction.y == -1:
#			vel = dash_direction.normalized() * 1000
#
#		falldown = false
#		can_dash = false
#		is_dashing = true
#		yield(get_tree().create_timer(0.2), "timeout")
#		is_dashing = false
#		falldown = true
	

# warning-ignore:function_conflicts_variable
func soul():
	if soul == true:
		soulanim.play("on")


#func hitplayer():
#	hit = true
#	can_move = false
#	anim.play("hit")
#	yield(get_tree().create_timer(.2), "timeout")
#	can_move = false
#	hit = false

# warning-ignore:unused_argument
func run(delta):
	if can_move == true:
		if Input.is_action_pressed("right") or Input.is_action_pressed("lt_right"):
			Global.flipped = false
			vel.x += speed
			anim.flip_h = false
			flute.flip_h = false
#			$flutebody.directionbody = Vector2.RIGHT
			$flutebody/muzzle.position.x = 8
			$flutebody/muzzle.flip_h = false
			$flutebody/muzzleoff.position.x = 16
			$flutebody/muzzleoff.flip_h = false
			if sign($flutebody/Position2D.position.x) == -1:
				$flutebody/Position2D.position.x *= -1
			flute.position = Vector2(4,3)
			Global.playerdir = 1
		if Input.is_action_pressed("left") or Input.is_action_pressed("lt_left"):
			$flutebody/muzzle.position.x = -24
			$flutebody/muzzle.flip_h = true
			$flutebody/muzzleoff.position.x = -16
			$flutebody/muzzleoff.flip_h = true
			Global.flipped = true
			vel.x -= speed
			anim.flip_h = true
			flute.flip_h = true
#			$flutebody.directionbody = Vector2.LEFT
			if sign($flutebody/Position2D.position.x) == 1:
				$flutebody/Position2D.position.x *= -1
			flute.position = Vector2(-4,3)
			Global.playerdir = -1

# warning-ignore:function_conflicts_variable
func gravity():
#	if falldown == true:
	vel.y += gravity
	if vel.y > 600: 
		vel.y = 600 # clamp falling speed
#		if is_on_wall() and vel.y > 100: 
#			vel.y = 5 # wall slide
		if is_on_wall(): 
			vel.y = 5 # wall slide

func friction():
	var running = Input.is_action_pressed("left") or Input.is_action_pressed("right")
	if not running and is_on_floor():
		vel.x *= stopping_friction
	else:
		vel.x *= running_friction


# warning-ignore:function_conflicts_variable
func anim():
	var running = Input.is_action_pressed("left") or Input.is_action_pressed("right") or Input.is_action_pressed("lt_left") or Input.is_action_pressed("lt_right")
	var runningboth = Input.is_action_pressed("left") and Input.is_action_pressed("right")
	
	if hit == false:
		if running and is_on_floor() and not runningboth:
			if playerhit == false:
				anim.play("run")
	if hit == false:
		if not running or runningboth:
			if not is_jumping:
				if playerhit == false:
					anim.play("idle")
	if playerhit == true:
		anim.play("hit")
#	if jumper == true:
#		anim.play("idle")
		

func jump():
#	if is_on_floor() or next_to_wall():
#		jumps_left = 2 # Recharge double-jump. 
#	if is_on_floor() or is_on_wall():
#	if is_on_floor():
#		jumps_left = 1 # Recharge double-jump. 
#	if Input.is_action_just_pressed("jump1") and jumps_left > 0:
	if Input.is_action_just_pressed("jump"):
		if is_on_floor() || !jumptimer.is_stopped():
			jumptimer.stop()
#		if Input.is_action_pressed("down"):
#			set_collision_mask_bit(DROP_THRU_BIT, false)
#		else:
			apply_squash_squeeze()
			anim.play("jump")
			if is_on_floor() == false:
				if is_on_wall():
					vel.x -= jump_powerx
			if vel.y > 0: vel.y = 0 # if I'm falling - ignore fall velocity
			vel.y -= jump_power
	
	if Input.is_action_pressed("down"):
		set_collision_mask_bit(1, false)
	
#		jumps_left -= 1
		# Jump away from the wall
#		if is_on_floor() == false:
#			if is_on_wall() and Input.is_action_pressed("right"):
#				vel.x -= jump_power
#				anim.flip_h = true
#			if is_on_wall() and Input.is_action_pressed("left"):
#				anim.flip_h = false
#				vel.x += jump_power
	if Input.is_action_just_released("jump") and vel.y < 0:
		vel.y = 0

#queue_free()
func dead():
	current_dead = true
	Global.playerdead = true
	var deadskullinst = deadskull.instance()
	get_parent().add_child(deadskullinst)
	deadskullinst.global_position = self.global_position
#	call_deferred("free")
	can_move = false
	vel = Vector2.ZERO
#	queue_free()
	$AnimatedSprite.hide()
	gravity = 0
	$flutebody/Flute.hide()
	$deadtimer.start()
	
#	is_dead = true

func _on_Area2D_area_entered(area):
	if area.name == "spikes":
# warning-ignore:return_value_discarded
		Global.playerhealth -= 10
#		Global.playerhealth -= 1
#		position.y -= 20


func _on_Area2D_body_entered(body):
	if body.name == "skull" or body.name == "Enemy" or body.name == "twoeyes":
		$hitsound.play()
	if body.name == "spikes":
# warning-ignore:return_value_discarded
#		get_tree().reload_current_scene()
		Global.playerhealth -= 10
#		Global.playerhealth -= 1
#		position.y -= 20


func _on_dashpower_dash():
	pass
#	gravity = 0
#	vel.y = 0
#	dashgravtime.start()
#	if Input.is_action_just_pressed("dash"):
#		gravity = 4.5


func _on_dashgrav_timeout():
	if gravity != 4.5:
		gravity = 4.5


func _on_soul_has_soul():
#	yield(get_tree().create_timer(1), "timeout")
	soul = true


func _on_Door_player_passed_door():
	if soul == true:
		soul = false
		animblink.play("blink lable point")
		Global.soulpoints += 1
	


func _on_invincebilityTimer_timeout():
	invince = false


func _on_lvl1_player_passed_door():
	if soul == true:
		soul = false
		animblink.play("blink lable point")
		Global.soulpoints += 1


func _on_deadtimer_timeout():
	get_tree().change_scene("res://menu.tscn")
