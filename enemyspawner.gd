extends Node2D

const blob = preload("res://enemy.tscn")
const skull = preload("res://skull.tscn")
const grave = preload("res://gravstone.tscn")
const bigbob = preload("res://BigBlobBob.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.start()


#func _process(delta):
	
func spawn():
	var randdirection = RandomNumberGenerator.new()
	randdirection.randomize()
	var number = randdirection.randi_range(0, 5)
	if number == 0 or number == 1 or number == 4:
		var blobinst = blob.instance()
		get_parent().add_child(blobinst)
		blobinst.global_position = $Position2D.global_position
	elif number == 3:
		var graveinst = grave.instance()
		get_parent().add_child(graveinst)
		graveinst.global_position = $Position2D.global_position
	elif number == 2:
		var skullinst = skull.instance()
		get_parent().add_child(skullinst)
		skullinst.global_position = $Position2D.global_position
	elif number == 5:
		var bobinst = bigbob.instance()
		get_parent().add_child(bobinst)
		bobinst.global_position = $Position2D.global_position
	$Timer.start()

func _on_Timer_timeout():
	if Global.playerdead == false:
		spawn()


func _on_deleter_respawn_blob():
	var blobinst = blob.instance()
	get_parent().add_child(blobinst)
	blobinst.global_position = $Position2D.global_position
	blobinst.modulate = "#ff5656"
	blobinst.SPEED = 90
	blobinst.angry = true
