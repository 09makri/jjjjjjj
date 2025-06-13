extends KinematicBody2D

onready var anim = $AnimatedSprite

var direction : Vector2 = Vector2.LEFT # default direction
var speed : float = 200 #put your rocket speed

func _physics_process(delta):
	translate(direction*speed*delta)


# Called when the node enters the scene tree for the first time.
func _ready():
	anim.play("active")


func _on_vbullethit_body_entered(body):
	if body.name == "player":
		Global.player.hit(1)
	if body.name == "tiles":
		queue_free()
