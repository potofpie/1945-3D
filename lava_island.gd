extends KinematicBody

var velocity = Vector3.ZERO
export var max_speed = 12
onready var pivot = $lava_island_model
func _physics_process(delta):
	Vector3(.5,10,.5)
	velocity = move_and_slide(velocity, Vector3.UP)
	
	#apply_movement(input_vector)
	#apply_gravity(delta)



func apply_movement(input_vector):
	velocity.x = input_vector.x * max_speed
	velocity.z = input_vector.z * max_speed
	if input_vector != Vector3.ZERO:
		pivot.look_at(translation, Vector3.UP)
