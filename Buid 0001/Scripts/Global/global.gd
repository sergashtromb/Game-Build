extends Node
# глобальный скрипт
var player = null # для обращения к сцене игрока из любой точки игры
var game = null # для обращения к сцене game из любой точки игры

func _ready():
	OS.center_window() # центрирование окна
	
func pause(s=1):
	get_tree().paused = bool(s) # если true ставит паузу если нет не ставит
	# делает курсор видимым при паузе и не видимым при игре
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED if !s else Input.MOUSE_MODE_VISIBLE)

func is_pause():
	return get_tree().paused

# функция добавления сцены к game
func sub(s):
	var scn = load("res://Scenes/UI/"+s+".tscn").instance() 
	player.UI.add_child(scn)  
	
func quit():
	get_tree().quit()
