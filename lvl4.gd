extends Node2D

const hole = preload("res://hole.tscn")
const skull = preload("res://skull.tscn")
const oneeye = preload("res://bulethell/Enemyhell.tscn")
const twoeye = preload("res://twoeyes.tscn")

var randpos


func _ready():
	randomize()
	var EnemyAmount = randi()%3+1
	print(var2str(EnemyAmount), "lvl4")
	var EnemySpawn = Global.make_random_int_array(EnemyAmount, 1, 3)
	print(var2str(EnemySpawn))
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
	Global.loadingvar = false
#	randomize()
	var x = rand_range(32, 456)
	var y = rand_range(32, 192)
	randpos = Vector2(x, y)
	Global.oldroomnumber = 4


func _process(delta):
	if get_tree().get_nodes_in_group("enemie").size() == 0:
		$newroomexplo._new_room_anim()
#			var holeinst = hole.instance()
#			get_tree().current_scene.add_child(holeinst)
#			holeinst.global_position = randpos
