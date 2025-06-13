extends Node2D

onready var health1 = $health/Sprite
onready var health2 = $health2/Sprite
onready var health3 = $health3/Sprite


func _ready():
	health1.show()
	health2.show()
	health3.show()


func _physics_process(delta):
	if Global.playerhealth == 9:
		health1.show()
		health2.show()
		health3.show() 
	if Global.playerhealth == 8:
		health1.hide()
		health2.show()
		health3.show() 
