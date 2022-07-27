extends Spatial
#FLOAT Controller
var depth_before_submerged: float = 1.0
var displacement: float = 0.3
onready var body = get_node("..")
var gravity = -ProjectSettings.get_setting("physics/3d/default_gravity")
var movement_force: float = 0.2
var _dir: float
onready var look_at_pos = get_node("../../../terrain/look_pos")
var bumping_objects: bool = false

func y_fixer():
	var float_controller_y_pos
	if  self.global_transform.origin.y < 0.0 :
		
		var displacement_force: float = clamp(- self.global_transform.origin.y / depth_before_submerged  * displacement, 0.0, 0.6 )
		
		body.apply_central_impulse(Vector3(0.0, -gravity * displacement_force, 0.0))
	elif  (self.global_transform.origin.y >= 3.0 ):
		print("too high")
		
	else: pass
	

func movement_controls(delta):
	
				
	var dir_z = Input.get_action_strength("MOVE_fwd") -  Input.get_action_strength("MOVE_back")
	var dir_x = Input.get_action_strength("MOVE_LEFT")- Input.get_action_strength("MOVE_RIGHT")
	body.apply_central_impulse(Vector3(clamp(dir_x, -movement_force, movement_force), 0.0, clamp(dir_z, -movement_force, movement_force)))

	#apply slight rotation tgo the body/ with a force that brings it back to vector.ZERO
	if dir_x != 0.0:
		body.apply_torque_impulse(Vector3(0.0, 0.0,  clamp(-dir_x , -0.003, 0.003)))
			
	if body.near_player and !body.bumping :
		body.skin.look_at(look_at_pos.global_transform.origin, Vector3.UP)
	
			
	
	
		
	
#	body.set_axis_velocity(Vector3(0.009,0.0,  0.009))


func _process(delta):
	y_fixer()
	movement_controls(delta)
