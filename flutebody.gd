extends KinematicBody2D

export var bulletscene : PackedScene
var muzzle = preload("res://muzzle.tscn")
var muzzledisabled = preload("res://muzzleoff.tscn")
var directionbody = Vector2.RIGHT
var canshoot = true
onready var shoottimer = $shoottimer
var smokeimpact = preload("res://dustpart.tscn")


func _ready():
	$muzzle.hide()


func _physics_process(_delta):
#	if Input.is_action_just_pressed("fire_weapon") and Global.playercanshoot == true:
	if Input.is_action_just_pressed("fire_weapon"):
		$AudioStreamPlayer.playrandom()
#		$muzzle/AnimationPlayer.play("play")
#		var smoke = smokeimpact.instance() as Particles2D
#		get_parent().get_parent().add_child(smoke)
#		smoke.position = $Position2D.global_position
#		Global.playercanshoot = false
#		if Global.active == true:
#		var muzzleinst = muzzle.instance() as Node2D
#		get_parent().get_parent().add_child(muzzleinst)
#		get_parent().get_parent().call_deferred("add_child", muzzleinst)
#		muzzleinst.global_position = $Position2D.global_position
#		else:
#			var muzzleoffinst = muzzledisabled.instance() as Node2D
#			get_parent().get_parent().add_child(muzzleoffinst)
#			muzzleoffinst.position = $muzzlepos.global_position
		var bullet = bulletscene.instance() as Node2D
#		if Global.flipped == false:
#			$muzzlepos.position.x = 8
#		else:
#			$muzzlepos.position.x = -8
		if sign($Position2D.position.x) == 1:
			bullet.set_bullet_direction(1)
#			$muzzlepos.position.x = 8
#			muzzleinst.set_muzzle_direction(1)
#			muzzleinst.scale.x = 1
			
			
		else:
			bullet.set_bullet_direction(-1)
#			$muzzlepos.position.x = -8
#			muzzleinst.set_muzzle_direction(-1)
#			muzzleinst.scale.x = -1
		get_tree().current_scene.add_child(bullet)
		bullet.global_position = $Position2D.global_position
		$shoottimer.start()
		if Global.longertimeshoot == true:
			$muzzle/AnimationPlayer.play("play")
		else:
			$muzzleoff/AnimationPlayer.play("playoff")
		
#		bullet.direction = directionbody


func _on_shoottimer_timeout():
	pass
#	Global.playercanshoot = true
