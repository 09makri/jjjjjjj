extends Node2D

signal player_passed_door

var TotalEnemyAmount = 3
var randpos
var holepos : Vector2
var timer
#onready var camera = $Camera2D
#onready var pos2 = $camerapos2
onready var healthanim = $health
onready var changescenetimer = $changesceneTimer
onready var transshader = $foley/transitionshader/AnimationPlayer

const hole = preload("res://hole.tscn")
const skull = preload("res://skull.tscn")
const oneeye = preload("res://bulethell/Enemyhell.tscn")
const twoeye = preload("res://twoeyes.tscn")


var t = 0.4
# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	var EnemyAmount = randi()%3+1
	print(var2str(EnemyAmount), "lvl1")
	var EnemySpawn = Global.make_random_int_array(EnemyAmount, 1, 3)
	print(var2str(EnemySpawn))
	$HealthHUD/transitionshader.hide()
	if EnemyAmount == 1:
		if EnemySpawn[0] == 1:
			var skullinst = skull.instance()
			add_child(skullinst)
		if EnemySpawn[0] == 2:
			var oneeyeinst = oneeye.instance()
			add_child(oneeyeinst)
		if EnemySpawn[0] == 3:
			var twoeyeinst = twoeye.instance()
			add_child(twoeyeinst) 
	elif EnemyAmount == 2:
		if EnemySpawn[0] == 1:
			var skullinst = skull.instance()
			add_child(skullinst)
		if EnemySpawn[0] == 2:
			var oneeyeinst = oneeye.instance()
			add_child(oneeyeinst)
		if EnemySpawn[0] == 3:
			var twoeyeinst = twoeye.instance()
			add_child(twoeyeinst) 
		if EnemySpawn[1] == 1:
			var skullinst = skull.instance()
			add_child(skullinst)
		if EnemySpawn[1] == 2:
			var oneeyeinst = oneeye.instance()
			add_child(oneeyeinst)
		if EnemySpawn[1] == 3:
			var twoeyeinst = twoeye.instance()
			add_child(twoeyeinst) 
	elif EnemyAmount == 3:
		if EnemySpawn[0] == 1:
			var skullinst = skull.instance()
			add_child(skullinst)
		if EnemySpawn[0] == 2:
			var oneeyeinst = oneeye.instance()
			add_child(oneeyeinst)
		if EnemySpawn[0] == 3:
			var twoeyeinst = twoeye.instance()
			add_child(twoeyeinst) 
		if EnemySpawn[1] == 1:
			var skullinst = skull.instance()
			add_child(skullinst)
		if EnemySpawn[1] == 2:
			var oneeyeinst = oneeye.instance()
			add_child(oneeyeinst)
		if EnemySpawn[1] == 3:
			var twoeyeinst = twoeye.instance()
			add_child(twoeyeinst) 
		if EnemySpawn[2] == 1:
			var skullinst = skull.instance()
			add_child(skullinst)
		if EnemySpawn[2] == 2:
			var oneeyeinst = oneeye.instance()
			add_child(oneeyeinst)
		if EnemySpawn[2] == 3:
			var twoeyeinst = twoeye.instance()
			add_child(twoeyeinst)
			
	
	
	var x = rand_range(32, 456)
	var y = rand_range(32, 192)
	randpos = Vector2(x, y)
	Global.oldroomnumber = 1
#	timer = Timer.new()
#	timer.connect("timeout",self,"_on_timer_timeout") 
	#timeout is what says in docs, in signals
	#self is who respond to the callback
	#_on_timer_timeout is the callback, can have any name
#	add_child(timer)
#	timer.set_wait_time(2)
	
	Global.campositionglobal = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
# warning-ignore:unused_argument
func _process(delta) -> void:
#	var amount = get_tree().get_nodes_in_group("enemie").size()
#	print(var2str(amount), "amount")
	randomize()
	var x = rand_range(32, 456)
	var y = rand_range(32, 122)
	holepos = Vector2(x, y)
#	if Global.scene_enemy_amount <= 0:
#		yield(get_tree().create_timer(2), "timeout")
#		get_tree().change_scene("res://lvl2.tscn")
	
	if get_tree().get_nodes_in_group("enemie").size() == 0:
		$newroomexplo._new_room_anim()
#		print("done")
#		$HealthHUD/transitionshader.show()
#		$HealthHUD/transitionshader/AnimationPlayer.play("transin")
#		yield(get_tree().create_timer(0.2), "timeout")
#		Global._random_room()
		
#		$foley/AnimationPlayer.play("tranisiotn in")
		
#		var holeinst = hole.instance()
#		get_tree().current_scene.add_child(holeinst)
#		holeinst.global_position = randpos
		
		
		
		
#		yield(get_tree().create_timer(2), "timeout")
#		Global._random_room()
#		SwitchScene.switchscene()
#		Global.switchscene("res://lvl2.tscn")
#		$holeTimer.start()
#		timer.start() #to start
#		yield(get_tree().create_timer(2), "timeout")
#		Global.goto_scene("res://lvl2.tscn")
#		call_deferred("get_tree().change_scene", "res://lvl2.tscn")
#		changescenetimer.start()
#		yield(get_tree().create_timer(2), "timeout")
#		get_tree().change_scene("res://lvl2.tscn")
	
#	healthanim.text = var2str(Global.playerhealth)
	
#	t += delta * 0.4


func _on_changecamre_body_entered(body):
	if body.name == "player":
		if Global.campositionglobal == 0:
			Global.campositionglobal = 798
		elif Global.campositionglobal == 798:
			Global.campositionglobal = 0
#		print("changecamera")
#		get_tree().change_scene("res://lvl2.tscn")
#		camera.position.linear_interpolate(pos2.position, t)


func _on_chanegcamrea2_body_entered(body):
	if body.name == "player":
		if Global.campositionglobal == 798:
			Global.campositionglobal = 1330


func _on_changecamrea3_body_entered(body):
	if body.name == "player":
		if Global.campositionglobal == 1330:
			Global.campositionglobal = 1862


func _on_end_body_entered(body):
	if body.name == "player":
		if Global.soulpoints > 0:
# warning-ignore:return_value_discarded
			get_tree().change_scene("res://store.tscn")
		else:
# warning-ignore:return_value_discarded
			get_tree().reload_current_scene()


func _on_changecamera4_body_entered(body):
	if body.name == "player":
		if Global.campositionglobal == 0:
			Global.campositionglobal = 2394
		if Global.campositionglobal == 1862:
			Global.campositionglobal = 2394


func _on_checksoul_body_entered(body):
	if body.name == "player":
		emit_signal("player_passed_door")
#	if body.name == "tiles":
#		new_pos()

#func _on_timer_timeout():
#	get_tree().change_scene("res://lvl2.tscn")

func new_pos():
	var holeinst = hole.instance()
	get_tree().current_scene.add_child(holeinst)
	holeinst.global_position = holepos
	

func _on_holeTimer_timeout():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://lvl2.tscn")


func _on_skull2_hitsound():
	$hitsound.play()

func _on_Enemy_hitsound():
	$hitsound.play()

func _on_twoeyes_hitsound():
	$hitsound.play()


func _on_changesceneTimer_timeout():
	print("timedout")
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://lvl2.tscn")
