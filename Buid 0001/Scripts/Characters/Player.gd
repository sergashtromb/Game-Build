extends KinematicBody2D


# базовые характеристики
export(int) var speed # скорость 
var anim # анимация 
var dir = 'Right' # направление 
var DO = 'Idle' # что делает в данный момент 
var can_climb_up = false # может ли герой куда либо забраться 
var can_climb_down = false # может ли герой куда либо спустится
var type = 'Human' # тип живого 
var count_climb = 4 # счетчик для frame анимации Climb 
var UI
# направление движения
var move = Vector2(0, 0) 




# присваивание по загрузке сцены
func _ready(): 
	G.player = self
	anim = $AnimatedSprite
	UI = $Camera2D/UI
func _physics_process(delta): 
	deal() 

	move = move_and_slide(move, Vector2(0, -1), false, 4, 0.78, false) 
	
#функция движения горизонтально
func deal():
	
	if Input.is_action_just_pressed("purk"): 
		anim.play("Purk")  
		if dir == 'Right':
			move.x = (speed * 2) 
			anim.flip_h = false 
		elif dir == 'Left':
			move.x = (-speed * 2) 
			anim.flip_h = true 
	elif Input.is_action_just_pressed("up"): 
		move.x = 0
		if can_climb_up == true: 
			DO = 'Up' 
			anim.play("Climb")   
			$CollisionShape2D.disabled = true 
			
	elif Input.is_action_just_pressed("down"): 
		move.x = 0
		if can_climb_down == true:
			DO = 'Down' 
			anim.play('Climb', true)  
			$CollisionShape2D.disabled = true  
			if dir == 'Right': 
				anim.flip_h = true 
			elif dir == 'Left':
				anim.flip_h = false
			

			
			
	if anim.animation != 'Purk' and anim.animation != 'Climb':
		if Input.is_action_pressed("left"):
			move.x = -speed 
			anim.play("Run") 
			anim.flip_h = true 
			dir = 'Left' 

		elif Input.is_action_pressed("right"):
			move.x = speed
			anim.play("Run") 
			anim.flip_h = false 
			dir = 'Right' 
			
		else:
			move.x = 0
			anim.play("Idle")
		


# окончание какой либо анимации
func _on_AnimatedSprite_animation_finished():
	if anim.animation == 'Purk':
		move.x = 0 
		anim.play('Idle')	  
		DO = 'Idle'
	elif anim.animation == 'Climb':
		move.x = 0 
		anim.play('Idle')  
		DO = 'Idle'
		count_climb = 4 
		$CollisionShape2D.disabled = false

# изменение какого либо кадра
func _on_AnimatedSprite_frame_changed():
	if anim.animation == 'Climb' and DO == 'Up':
		var f = anim.get_frame() 
		match f:
			1:
				if count_climb == 4: 
					if dir == 'Right':
						global_position.x -= 3
						global_position.y -= 7  
					elif dir == 'Left':
						global_position.x += 3
						global_position.y -= 7  
					count_climb -= 1 
			2:
				if count_climb == 3:
					global_position.y -= 3
					count_climb -= 1 
			3:
				if count_climb == 2: 
					if dir == 'Right':
						global_position.x += 5 
						global_position.y -= 9  
					elif dir == 'Left':
						global_position.x -= 5 
						global_position.y -= 9
					count_climb -= 1 
			4:
				if count_climb == 1: 
					if dir == 'Right':
						global_position.x += 8 
						global_position.y -= 13 
					elif dir == 'Left':
						global_position.x -= 8 
						global_position.y -= 13
					count_climb -= 1
			
	elif anim.animation == 'Climb' and DO == 'Down':
		var f = anim.get_frame() 
		match f:
			4:
				if count_climb == 4: 
					if dir == 'Right':
						global_position.x += 8 
						global_position.y += 12
					elif dir == 'Left':
						global_position.x -= 8 
						global_position.y += 12
					count_climb -= 1 
			3:
				if count_climb == 3:
					if dir == 'Right':
						global_position.x += 4 
						global_position.y += 8 
					elif dir == 'Left': 
						global_position.x -= 4 
						global_position.y += 8
					count_climb -= 1 
			2:
				if count_climb == 2: 
					global_position.y += 4	
					count_climb -= 1 
			1:
				if count_climb == 1: 
					global_position.y += 8
					count_climb -= 1
