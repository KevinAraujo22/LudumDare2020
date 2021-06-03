extends KinematicBody2D

var preco = 50
export (PackedScene) var tiro
export (float) var tempo
var can_shoot = false
var alvo
var atirar = 0
var olhar = false
var inimigos = []

func _ready():
	$Timer.wait_time = tempo

func _physics_process(delta):
	#checa e dispara a função de tiro
	if can_shoot:
		if olhar:
			if !weakref(inimigos[0]).get_ref():
				inimigos.remove(0)
#			shoot(alvo.position)
			shoot(inimigos[0].position)
#			$AnimatedSprite.look_at(alvo.position)
			$AnimatedSprite.look_at(inimigos[0].position)

func shoot(pos):
	var b = tiro.instance()
	var a = (pos - $AnimatedSprite/Area2D.global_position).angle()
	b.start($AnimatedSprite/Area2D.global_position, a + rand_range(-0.05, 0.05))
	get_tree().current_scene.add_child(b)
	can_shoot = false
	$atirar.start()
	pass

func _on_Timer_timeout():
	atirar = 0
	$atirar.start()
	

func _on_Area_body_entered(body):
	#Identifica o alvo e torna verdadeira a condição para atirar
	if body.is_in_group("enemies"):
		can_shoot = true
		inimigos.append(body)
		alvo = inimigos[0]
		olhar = true

func _on_Area_body_exited(body):
	if body.is_in_group("enemies"):
		#torna falsa a condição para tiro e para o Timer, impedindo que reative a condição
		can_shoot = false
		olhar = false
		inimigos.remove(0)
		$Timer.stop()
		$atirar.stop()

func _on_atirar_timeout():
	if atirar <= 10:
		atirar += 1
		can_shoot=true
	else:
		$atirar.stop()
		$Timer.start()
