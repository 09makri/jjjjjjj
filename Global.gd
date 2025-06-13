extends Node

var skulltarget = null
var playerhealth = 1
var playerdead = false
var is_dashing =  false
var player = null
var gunspread = 0.08
var campositionglobal = 0
var soulpoints = 0
var target = null
var attackpwr = 1
var dashlenght = 0.15
var current_scene = null
var scene_enemy_amount = 0
var roomnumber = 0
var oldroomnumber = 0
var loadingvar = false
var roomArray
var Level2 = load("res://lvl2.tscn")
var node
var currentarrayPlace = 0
var playerdir = 1
var playercanshoot = true
var sec_perbeat
var timerstreak = 0
var score = 0
var beatpos
var active
var longertimeshoot = true
var flipped = false
var activebullet 
const loading = preload("res://load.tscn")
#const scene1 = preload("res://lvl1.tscn")
#const scene2 = preload("res://lvl2.tscn")
#const scene3 = preload("res://lvl3.tscn")

func _random_room():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://load.tscn")
#	var loadinginst = loading.instance()
#	add_child(loadinginst)
#	match roomnumber:
#		1:
#			if oldroomnumber == 1:
#				roomnumber = randi()%3+1
#			else:
#
## warning-ignore:return_value_discarded
#				get_tree().change_scene("res://lvl1.tscn")
## 				node = Level2.instance()
## 				get_node("/root/Main/Level1").queue_free()
## 				get_node("/root/Main").add_child(node)
#		2:
#			if oldroomnumber == 2:
#				roomnumber = randi()%3+1
#			else:
## warning-ignore:return_value_discarded
#				get_tree().change_scene("res://lvl2.tscn")
#		3:
#			if oldroomnumber == 3:
#				roomnumber = randi()%3+1
#			else:
## warning-ignore:return_value_discarded
#				get_tree().change_scene("res://lvl3.tscn")
	

func make_random_int_array(array_size, min_value=0, max_value=100):
	var return_val = []
	var random_gen = RandomNumberGenerator.new()
	random_gen.randomize()
	for i in range(0, array_size):
		return_val.append(random_gen.randi_range(min_value, max_value))
	return return_val

func _process(_delta) -> void:
	
	
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()
	if Input.is_action_just_pressed("reload"):
# warning-ignore:return_value_discarded
		get_tree().reload_current_scene()

func switchscene(path):
	yield(get_tree().create_timer(2), "timeout")
# warning-ignore:return_value_discarded
	get_tree().change_scene(path)

func _ready():
	score = 0
	Global.playerdead = false
	roomArray = make_random_int_array(5, 1, 3)
#	print(roomArray, "rooms")
#	var room_array = make_random_int_array(3, 1, 3)
#	print (room_array)

#	loadinginst = loading.instance()
	var root = get_tree().get_root()
	current_scene = root.get_child(root.get_child_count() - 1)

func goto_scene(path):
	# This function will usually be called from a signal callback,
	# or some other function in the current scene.
	# Deleting the current scene at this point is
	# a bad idea, because it may still be executing code.
	# This will result in a crash or unexpected behavior.

	# The solution is to defer the load to a later time, when
	# we can be sure that no code from the current scene is running:

	call_deferred("_deferred_goto_scene", path)


func _deferred_goto_scene(path):
	# It is now safe to remove the current scene
	current_scene.free()

	# Load the new scene.
	var s = ResourceLoader.load(path)

	# Instance the new scene.
	current_scene = s.instance()

	# Add it to the active scene, as child of root.
	get_tree().get_root().add_child(current_scene)

	# Optionally, to make it compatible with the SceneTree.change_scene() API.
	get_tree().set_current_scene(current_scene)



