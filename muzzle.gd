extends Node2D
var direction = 1


# Called when the node enters the scene tree for the first time.
func _ready():
	if Global.flipped == false:
		$muzzlesprite.flip_h = false
	else:
		$muzzlesprite.flip_h = true

func _process(_delta):
	pass
#	if Global.flipped == false:
#		$muzzle.flip_h = false
#	else:
#		$muzzle.flip_h = true

func set_muzzle_direction(dir):
	direction = dir
	if dir == -1:
		$muzzlesprite.flip_h = true
#	else:
#		$muzzle.flip_h = false
