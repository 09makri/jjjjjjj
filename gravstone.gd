extends KinematicBody2D


const GRAVITY = 8
const SPEED = 80
const UP = Vector2.UP
const dashfx = preload("res://dash fx.tscn")
const blood = preload("res://blood.tscn")
const deadsound = preload("res://deadsound.tscn")
var velocity = Vector2()
export var direction = 1
var health = 2
var canwalk = true

func _ready():
	canwalk = true
	var randdirection = RandomNumberGenerator.new()
	randdirection.randomize()
	var number = randdirection.randi_range(0, 1)
	if number == 1:
		direction = 1
	elif number == 0:
		direction = -1
	
	
	health = 2
	add_to_group("enemy")
	$AnimationPlayer.play("run")

func _physics_process(delta):
	if Global.playerdead == true:
		canwalk = false
#	$Label.text = var2str(health)
	if health <= 0:
		dead()
	if canwalk == true:
		velocity.x = SPEED * direction
	if direction == 1:
		$AnimatedSprite.flip_h = false
	else:
		$AnimatedSprite.flip_h = true
	velocity.y += GRAVITY
	velocity = move_and_slide(velocity, UP)
	if $RayCastRight.is_colliding() == true:
		direction = -1
	if $RayCastLeft.is_colliding() == true:
		direction = 1
#	if is_on_wall():
#		direction = direction * -1
#		$RayCast2D.position.x *= -1
#	if $RayCast2D.is_colliding() == false:
#		direction *= -1
#		$RayCast2D.position.x *= -1

func dead():
	var deadsoundinst = deadsound.instance()
	get_parent().add_child(deadsoundinst)
	Global.score += 1
	queue_free()


func _on_Area2D_body_entered(body):
	if body.name == "player":
		Global.player.hit(1)
		var dashinst = dashfx.instance()
		get_tree().current_scene.add_child(dashinst)
		dashinst.global_position = global_position
		dashinst.rotation = global_position.angle_to_point(Global.player.global_position)
		
	if body.name == "bullet":
		if body.active == true:
			$hitsound.play()
	#		position.x -= 10 * direction
			$AnimationPlayer.play("hit")
			canwalk = false
			$stopTimer.start()
			health -= 1
			get_parent().get_node("ScreenShake").screen_shake(0.3, 3, 10)
			var blood_instance = blood.instance()
			get_tree().current_scene.add_child(blood_instance)
			blood_instance.global_position = $Position2D.global_position
			blood_instance.rotation = global_position.angle_to_point(Global.player.global_position)
			blood_instance.scale = Vector2(0.8,0.8)
	




func _on_stopTimer_timeout():
	canwalk = true
	$AnimationPlayer.play("run")
