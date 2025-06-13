extends KinematicBody2D

# warning-ignore:unused_signal
signal hitsound

onready var hitsound = $hitsound
onready var anim = $AnimatedSprite
onready var positiontimer = $PositionTimer
onready var move = $AnimationPlayer
onready var gun = $gun
const blood = preload("res://blood.tscn")
const dashfx = preload("res://dash fx.tscn")
const pooffx = preload("res://poofFX.tscn")
var health = 1
var newpos : Vector2
var randtime
var can_fly = true

export var xrangex = 32
export var xrangey = 456
export var yrangex = 32
export var yrangey = 192

func _ready():
	$colliderstwo/CollisionShape2D.disabled = false
	add_to_group("enemie")
	anim.show()
#	move.play("move")
	new_position()
	anim.play("active")

func new_position():
	if can_fly == true:
		var poofinst = pooffx.instance()
		get_tree().current_scene.call_deferred("add_child", poofinst)
		poofinst.global_position = global_position
		randomize()
		var x = rand_range(xrangex, xrangey)
		var y = rand_range(yrangex, yrangey)
		position = Vector2(x, y)
		positiontimer.start()

# warning-ignore:unused_argument
func _physics_process(delta):
	randomize()
	randtime = rand_range(6, 12)
	positiontimer.wait_time = round(randtime)

func _on_colliderstwo_body_entered(body):
	if body.name == "tiles":
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
			dead2()
		else:
			Global.player.hit(1)
	

func dead2():
	$colliderstwo/CollisionShape2D.call_deferred("disabled", true)
#	$colliderstwo/CollisionShape2D.disabled = true
	gun.notdead = false
	can_fly = false
	anim.hide()
	yield (hitsound, "finished")
	queue_free()

func dead():
	call_deferred("remove_from_group", "enemie")
	$colliderstwo/CollisionShape2D.set_deferred("disabled",true)
	gun.notdead = false
	can_fly = false
	anim.hide()

func _on_PositionTimer_timeout():
	print(var2str(randtime))
	new_position()



