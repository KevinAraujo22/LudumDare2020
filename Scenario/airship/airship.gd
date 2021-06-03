extends KinematicBody2D

var flip = true 
var initial_psition
var final_position
var velocity = 7.5
var life = 50


func _ready():
	initial_psition = position.x
	final_position = initial_psition + 1000

	
func _process(delta):
	if(initial_psition <= final_position and flip):
		position.x += velocity
		if(position.x >= final_position):
			flip = false
	if(position.x >= initial_psition and !flip):
		position.x -= velocity
		if(position.x <= initial_psition):
			flip = true
