extends CharacterBody3D

@export var max_speed = 100
@export var wind_speed = 70
@export var GRAVITY = 70
@export var BACK_WALL = -160
@export var FRONT_WALL = -160
@export var TOP_WALL = 90
@export var BOTTOM_WALL = -90


@onready var rCannon = $rCannon
@onready var lCannon = $lCannon
@onready var bomberModel = $bomberModel

# Bullets
var bullet = preload("res://scenes/player/bullet.tscn")
var bulletInstance 


var hanginDown = false 
var hanginUp = false





func shoot_bullets(_delta, cannon, key):
	if Input.is_action_just_pressed(key):
		bulletInstance = bullet.instantiate()
		bulletInstance.position = cannon.global_position
		bulletInstance.transform.basis = cannon.transform.basis
		get_parent().add_child(bulletInstance)



func _physics_process(_delta):
	shoot_bullets(_delta, rCannon, 'shoot_r')
	shoot_bullets(_delta, lCannon, 'shoot_l')
	var input_vector = get_input_vector()
	apply_movement(input_vector)
	set_velocity(velocity)
	set_up_direction(Vector3.UP)
	move_and_slide()
	velocity = velocity


func get_input_vector():
	var input_vector = Vector3.ZERO
	input_vector.z = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	input_vector.x = Input.get_action_strength("move_back") - Input.get_action_strength("move_forward")
	return input_vector.normalized()
	
func apply_movement(input_vector):
	var z_lean = bomberModel.get_rotation().z
	if(input_vector.x == 1):
		hanginUp = false
		hanginDown = true
	if(input_vector.x == -1):
		hanginUp = true
		hanginDown = false
	var move = (max_speed + abs(z_lean) * 5)
	if(hanginDown):
		if(bomberModel.global_position.x > TOP_WALL):
			velocity.x = 0
		else:
			velocity.x = move
		if(z_lean > -.5):
			bomberModel.rotate_z(.03)
	if(hanginUp):
		if(bomberModel.global_position.x < BOTTOM_WALL):
			velocity.x = 0
		else:
			velocity.x = -move
			
		if(z_lean < .5):
			bomberModel.rotate_z(-.03)
	if(input_vector.z <= 0 && (BACK_WALL < bomberModel.global_position.z)):  # if no forward input move backwardsa
		velocity.z = -1 * (wind_speed + abs(z_lean * 10) * 10)
	else: 
		velocity.z = input_vector.z * (max_speed + abs(10) * 10) # if input use speed

# keep for death state
func apply_gravity(delta):
	velocity.y -= GRAVITY * delta


