extends Position2D


#var campositionx = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	update_position_cam()
	set_as_toplevel(true)

# warning-ignore:unused_argument
func _physics_process(delta):
	update_position_cam()

func update_position_cam():
	position.x = Global.campositionglobal


