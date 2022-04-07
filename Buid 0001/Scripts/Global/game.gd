extends Node



func _ready(): 
	G.game = self
	G.pause(0) 
	
func _process(delta): 
	# если нажмет на паузу
	if Input.is_action_just_pressed("pause"): 
		G.pause(1) 
		G.sub('Menu') # подключение меню после нажатия паузы
		
