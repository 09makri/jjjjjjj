extends KinematicBody2D

var health = 3
var dead = false

onready var anim = $AnimatedSprite
onready var hitsound = $hitsound

const blood = preload("res://blood.tscn")
const dashfx = preload("res://dash fx.tscn")

func _ready():
	anim.play("idle")


func _process(delta):
	if health <= 0:
		dead = true
		dead()


func _on_hitboxcrystal_body_entered(body):
	if body.name == "player":
#		if health <= 1:
#			dead()
		if Global.player.is_dashing == true:
#			emit_signal("hitsound")
				
			hitsound.play()
			get_parent().get_node("ScreenShake").screen_shake(0.3, 6, 10)
#			can_fly = false
			health -= Global.attackpwr
			anim.play("hit")
			var blood_instance = blood.instance()
			get_tree().current_scene.add_child(blood_instance)
			blood_instance.global_position = global_position
			blood_instance.rotation = global_position.angle_to_point(Global.player.global_position)
			var dashinst = dashfx.instance()
			get_tree().current_scene.add_child(dashinst)
			dashinst.global_position = global_position
			dashinst.rotation = global_position.angle_to_point(Global.player.global_position)
			if dead == false:
				yield(get_tree().create_timer(0.2), "timeout")
#				stoptimer.start()
				anim.play("idle")
#				can_fly = true 
		else:
			Global.player.hit(1)
#			Global.target = self

func dead():
#	can_fly = false
	$hitboxcrystal/CollisionShape2D.disabled = true
#	$Light2D.enabled = false
#	$Light2D2.enabled = false
	anim.hide()
	yield (hitsound, "finished")
	queue_free()

func shoot():
	pass

func _on_gun_shooting():
	anim.play("active")
	yield(get_tree().create_timer(1), "timeout")
	anim.play("idle")
