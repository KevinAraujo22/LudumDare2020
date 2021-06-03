extends Control

signal atualizar_vida(vida)

func _on_Poisorret_atualizar_vida(vida):
	emit_signal("atualizar_vida", vida)
	pass
