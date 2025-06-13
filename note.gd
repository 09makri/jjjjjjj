extends KinematicBody2D

export var smokeimpact : PackedScene
var offimpact = preload("res://offdustpart.tscn")
const SPEED = 400
var velocity = Vector2()
var direction = 1
var active = false
var gone = false

func _ready():
#	if Global.playercanshoot == true:
	if Global.longertimeshoot == true:
		get_parent().get_node("ScreenShake").screen_shake(0.3, 2, 3)
		$AnimatedSprite.play("1active")
		$Light2D.enabled = true
#		print(var2str(Global.playercanshoot))
		Global.timerstreak += 1
		active = true
		Global.activebullet = true
#	if Global.playercanshoot == false:
	if Global.longertimeshoot == false:
		$AnimatedSprite.play("1not")
		$Light2D.enabled = false
#		print(var2str(Global.playercanshoot))
		Global.timerstreak = 0
		active = false
		Global.activebullet = false
#	$AnimatedSprite.play("1active")

func set_bullet_direction(dir):
	direction = dir
	if dir == -1:
		$AnimatedSprite.flip_h = true
		

func _physics_process(delta):
	velocity.x = SPEED * delta * direction
	translate(velocity)
	
#	if $bulletcaster.get_collider(is_in_group("enemy")):
#		$bulletcaster.get_collider()
		
	

func _process(_delta):
	if $bulletcaster.is_colliding():
		var object = $bulletcaster.get_collider()
		if object.has_method("hit"):
			object.hit()
			print("rayeay")
			queue_free()

#	move_and_collide(direction * SPEED * delta)
	


func _on_Area2D_body_entered(body):
	
#	if body.name == "enemy":
#		gone = true
#		$AnimatedSprite.hide()
#		$CollisionShape2D.disabled = true
#		yield(get_tree().create_timer(.1), "timeout")
#		queue_free()
#	if body.name == "skull":
#		gone = true
#		$AnimatedSprite.hide()
#		$CollisionShape2D.disabled = true
#		$Light2D.enabled == false
#		yield(get_tree().create_timer(.1), "timeout")
#		queue_free()
	if body.is_in_group("enemy"):
		gone = true
		$AnimatedSprite.hide()
		Global.active = true
		var smoke = smokeimpact.instance() as Particles2D
		get_parent().add_child(smoke)
		smoke.global_position = self.position
		if direction == -1:
			smoke.scale.x = 1
		else:
			smoke.scale.x = -1
#		set_deferred($CollisionShape2D.disabled, true)
#		$Light2D.enabled == false
#		yield(get_tree().create_timer(.1), "timeout")
		queue_free()
	if gone == false:
		if body.name == "TileMap" or body.name == "TileMap3":
			if active == true:
				Global.active = true
				var smoke = smokeimpact.instance() as Particles2D
				get_parent().add_child(smoke)
				smoke.global_position = self.position
				if direction == -1:
					smoke.scale.x = 1
				else:
					smoke.scale.x = -1
				queue_free()
			else:
				var offsmoke = offimpact.instance() as Particles2D
				get_parent().add_child(offsmoke)
				offsmoke.global_position = self.position
				if direction == -1:
					offsmoke.scale.x = 1
				else:
					offsmoke.scale.x = -1
	#	print("smoke")
	#	if direction == -1:
	#		smoke.scale.x = -1
	#	else:
	#		smoke.scale.x = 1
			queue_free()
