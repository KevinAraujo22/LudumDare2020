extends HBoxContainer

var vida_atual = 500

func _on_Interface_atualizar_vida(vida):
	animate_value(vida_atual,vida)
	vida_atual = vida
	$HealthBar.value = vida
	pass # Replace with function body.

func animate_value(start,end):
	$Tween.interpolate_property($HealthBar, "value", start, end, 0.3, Tween.TRANS_ELASTIC,Tween.EASE_OUT)
	$Tween.start()
