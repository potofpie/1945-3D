extends CharacterBody3D

@export var max_speed = 8
@export var gravity = 70


@onready var pivot = $plane_model

func _physics_process(delta):
	var input_vector = get_input_vector()
	apply_movement(input_vector)
	set_velocity(velocity)
	set_up_direction(Vector3.UP)
	move_and_slide()
	velocity = velocity
	
	Input

func get_input_vector():
	var input_vector = Vector3.ZERO
	input_vector.z = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	input_vector.x = Input.get_action_strength("move_back") - Input.get_action_strength("move_forward")
	return input_vector.normalized()
	
func apply_movement(input_vector):
	var z_lean = pivot.get_rotation().z
	if(velocity.x < 0 && z_lean < .5): 
		pivot.rotate_z(-.02)
	if(velocity.x > 0 && z_lean > -.5): 
		pivot.rotate_z(.02)
	velocity.x = input_vector.x * (max_speed + abs(z_lean) *10)
	velocity.z = input_vector.z * (max_speed + abs(z_lean) *10)

	#if input_vector != Vector3.ZERO:
	#	pivot.look_at(translation, Vector3.UP)

	
# keep for death state
func apply_gravity(delta):
	velocity.y -= gravity * delta
	
