extends Node

var island = preload("res://scenes/enviroment/island.tscn")
var islandInstance 

var scout = preload("res://scenes/enemy/scout.tscn")
var scoutInstance 

@onready var downSpawnPoint = $downSpawnPoint
@onready var middleSpawnPoint = $middleSpawnPoint
@onready var upSpawnPoint = $upSpawnPoint
var spawnArray = ["down","middle","up"]

var rng = RandomNumberGenerator.new()

func _on_timer_timeout_island():
	islandInstance = island.instantiate()
	islandInstance.position = middleSpawnPoint.global_position
	islandInstance.position.x = rng.randf_range(-8.0, 8.0) * 10
	islandInstance.position.y = islandInstance.position.y - 20 
	islandInstance.transform.basis = middleSpawnPoint.transform.basis
	get_parent().add_child(islandInstance)


func _on_timer_timeout_scout():	
	var randomSpawnIdx = rng.randi_range(0,2)
	var spawn = "middle" # spawnArray[randomSpawnIdx]
	scoutInstance = scout.instantiate()
	
	match spawn:
		"down":
			scoutInstance.position = downSpawnPoint.global_position
			scoutInstance.transform.basis = downSpawnPoint.transform.basis
			get_parent().add_child(scoutInstance)
		"middle":
			scoutInstance.position = middleSpawnPoint.global_position
			scoutInstance.position.x = rng.randf_range(-10.0, 10.0) * 10
			scoutInstance.transform.basis = middleSpawnPoint.transform.basis
			get_parent().add_child(scoutInstance)
		"up":
			scoutInstance.position = upSpawnPoint.global_position
			scoutInstance.transform.basis = upSpawnPoint.transform.basis
			get_parent().add_child(scoutInstance)
