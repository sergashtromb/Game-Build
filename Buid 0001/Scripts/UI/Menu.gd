extends Control





func _process(delta): 
	# если нажмет на паузу
	if Input.is_action_just_pressed("pause"): 
		G.pause(0) 
		queue_free() # удаление после снятия с паузы




func _on_next_pressed():
	G.pause(0) 
	queue_free()


func _on_exit_pressed():
	G.quit()
