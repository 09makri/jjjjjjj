extends Node2D


onready var anim = $AnimationPlayer
onready var points = $CanvasLayer/CenterContainer/Label
onready var explain = $CanvasLayer/explain

func _ready():
	pass # Replace with function body.

func _process(delta):
	points.text = var2str(Global.soulpoints)
	if Global.soulpoints <= 0:
		get_tree().change_scene("res://lvl1.tscn")


func _on_TextureRect_mouse_entered():
	anim.play("badge1out")
	explain.text = "More attack power"
	Global.attackpwr += 1
	Global.soulpoints -= 1

func _on_TextureRect_mouse_exited():
	anim.play("badge1in")
	explain.text = ""

func _on_TextureRect2_mouse_entered():
	anim.play("badge2out")
	explain.text = "Longer reach"
	Global.dashlenght = 0.20
	Global.soulpoints -= 1

func _on_TextureRect2_mouse_exited():
	anim.play("badge2in")
	explain.text = ""

func _on_TextureRect3_mouse_entered():
	anim.play("badge3out")
	explain.text = "Get more soul points with every soul collected"
	Global.soulpoints -= 1
	

func _on_TextureRect3_mouse_exited():
	anim.play("badge3in")
	explain.text = ""

func _on_TextureRect4_mouse_entered():
	anim.play("badge4out")
	explain.text = "Wait and save soul point"
	get_tree().change_scene("res://lvl1.tscn")

func _on_TextureRect4_mouse_exited():
	anim.play("badge4in")
	explain.text = ""
