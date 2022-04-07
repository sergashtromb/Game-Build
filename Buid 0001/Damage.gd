extends Area2D





func _on_Damage_area_entered(area):
	if area.name == "Body":
		print("DAMAGE!")
