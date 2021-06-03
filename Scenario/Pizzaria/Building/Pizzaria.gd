extends Node2D

var inside_floor_resource = preload("res://Scenario/Pizzaria/Inside/InsideFloor.tscn")
var floor_resource = preload("res://Scenario/Pizzaria/Floors/Floor.tscn")
var floor_count = 2

var start_flooring
var floor_size
var life:int = 100
func _ready():
	start_flooring = ($Base.texture.get_size()*-$Base.scale)/2
	for i in range(1,floor_count+1):
		add_floor(i)
	
	pass

func add_floor(ffloor):
	#instances outside vision of the floor
	var new_f = floor_resource.instance()
	$Floors.add_child(new_f)
	var floor_height = new_f.get_node("Sprite").texture.get_size().y*-new_f.get_node("Sprite").scale.y
	var height = start_flooring.y+(floor_height*ffloor)-floor_height/2
	new_f.position = Vector2(0,height)
	new_f.id = ffloor
	#instances inside vision of the floor
	var new_fll = inside_floor_resource.instance()
	$Inside.add_child(new_fll)
	
	new_fll.global_position = new_f.global_position

func remove_floor(fflor):
	$TurretStore/Panel.visible = false
	for i in range(fflor,floor_count):
		$Inside.get_child(i)._fall()
		$Floors.get_child(i)._fall()
		$Floors.get_child(i).id-=1
	$Floors.get_child(fflor-1).queue_free()
	$Inside.get_child(fflor-1).queue_free()
	floor_count -=1


func _damage(dam):
	life-= dam



var inside = false
var can_enter = false

func _physics_process(_delta):
	if Input.is_action_just_pressed("space") and can_enter:
		if inside:
			exit()
			inside = false
		else:
			enter()
			inside = true
	elif Input.is_action_just_pressed("shift") and can_teleport:
		get_tree().current_scene.get_node("Player").position.y-=300


func _on_Pizzaria_body_entered(body):
	if body.is_in_group("player"):
		$"TurretStore/Message".text = "Press 'Space' to enter"
		$"TurretStore/Message".visible = true
		can_enter = true
		pass
	pass # Replace with function body.

func enter():
	$Base.modulate.a = 0.3
	$Floors.modulate.a = 0.3
	$Inside.visible = true

func exit():
	$Base.modulate.a = 1
	$Floors.modulate.a = 1
	$Inside.visible = false
func _on_Pizzaria_body_exited(body):
	if body.is_in_group("player"):
		can_enter = false
		if inside:
			inside = false
			exit()
		pass
		$"TurretStore/Message".visible = false
	pass # Replace with function body.
	
	
	
	
	
	

var can_teleport:bool = false
func _on_Area2D_body_entered(body):
	if body.is_in_group("player") and inside:
		$"TurretStore/Message".text = "Press 'Shift' to move to the upper floor"
		$"TurretStore/Message".visible = true
		can_teleport = true
	pass # Replace with function body.


func _on_Area2D_body_exited(body):
	if body.is_in_group("player"):
		can_teleport = false
		$"TurretStore/Message".visible = false
	pass # Replace with function body.
