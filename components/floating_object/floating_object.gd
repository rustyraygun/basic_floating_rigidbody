extends RigidBody

onready var skin = $MeshInstance
var bumping: bool = false
var near_player: bool = false


func _on_Area_area_entered(area):
	if area.is_in_group("level_object"):
		bumping = true
	
	if area.is_in_group("cam_box"):
		near_player = true
		


func _on_Area_area_exited(area):
	if area.is_in_group("level_object"):
		bumping = false
	
	if area.is_in_group("cam_box"):
		near_player = false
