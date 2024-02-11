extends Node3D

@export var SPEED = 300.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += transform.basis * Vector3(0,0,SPEED) * delta
	var Bodies = $Area3D.get_overlapping_bodies()
	for b in Bodies:
		if(b.name == 'scoutBody'):
			Global.score =  Global.score + 1
			b.queue_free()
			queue_free()


