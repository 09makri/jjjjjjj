extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_PLAy_pressed():
	$CenterContainer/VBoxContainer/AnimationPlayer.play("playselect")

func changescene():
	get_tree().change_scene("res://Standard.tscn")

func _on_Button_pressed():
	get_tree().quit()


func _on_PLAy_mouse_entered():
	$CenterContainer/VBoxContainer/playblip.show()
func _on_PLAy_mouse_exited():
	$CenterContainer/VBoxContainer/playblip.hide()


func _on_Button_mouse_entered():
	$CenterContainer/VBoxContainer/quitblip.show()


func _on_Button_mouse_exited():
	$CenterContainer/VBoxContainer/quitblip.hide()
