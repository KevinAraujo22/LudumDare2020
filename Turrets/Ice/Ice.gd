extends Area2D

var speed = 250 #velocidade do projétil
var velocity = Vector2() 
var ataque = 10 #dano que causará ao acertar

func start(pos, dir):
	position = pos 
	rotation_degrees = rad2deg(dir)+90 
	velocity = Vector2(speed, 0).rotated(dir) 

func _physics_process(delta):
	position += velocity * delta #delimita a velocidade em quadros por segundo

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_Bullet_body_entered(body):
	if body.is_in_group("enemies"):
		body._damage(ataque)
		body.get_node("Reload").wait_time *=2
		if body.SPEED <= 0:
			body.SPEED = 0
		else:
			body.SPEED -= 50
		queue_free()
