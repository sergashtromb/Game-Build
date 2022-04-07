extends Area2D


export(String, 'Left', 'Right') var dir  
export(String) var type
var direction 
var t
func _ready():
	direction = dir 
	t = type
	



func _on_Climb_place_body_entered(body):
	if body.name != 'StaticBody2D':
		if body.type == 'Human': 
			if t == 'Up':
				if body.dir == direction:
					body.can_climb_up = true
			elif t == 'Down': 
				if body.dir != direction:
					body.can_climb_down = true


func _on_Climb_place_body_exited(body):
	if body.name != 'StaticBody2D':
		if body.type == 'Human':
			if t == 'Up':
				body.can_climb_up = false 
			elif t == 'Down':
				body.can_climb_down = false
