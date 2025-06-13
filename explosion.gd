extends Node2D


onready var deltettimer = $Deltettimer

func _ready():
	$AnimatedSprite.play("active")
	deltettimer.start()

func _process(delta):
	pass
#	yield( get_node("AnimatedSprite"), "finished" )
#	queue_free()


func _on_hurtexplosion_body_entered(body):
	if body.name == "player":
		get_parent().get_node("ScreenShake").screen_shake(0.5, 5, 7)
#		get_node("ScreenShake").screen_shake(0.5, 5, 2)
		Global.player.hit(3)


func _on_Deltettimer_timeout():
	queue_free()
