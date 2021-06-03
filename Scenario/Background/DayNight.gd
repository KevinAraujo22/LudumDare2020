extends Node


var day = true

var day_sky = Color("#ff03b6e6")
var night_sky = Color("#ff1b2632")
	

func day2night():
	$Tween.interpolate_method(VisualServer,"set_default_clear_color",day_sky,night_sky,5.0)
	$Tween.start()

func night2day():
	$Tween.interpolate_method(VisualServer,"set_default_clear_color",night_sky,day_sky,5.0)
	$Tween.start()


func _on_Timer_timeout():
	if day:
		day2night()
	else:
		night2day()
	day = !day
	pass # Replace with function body.
