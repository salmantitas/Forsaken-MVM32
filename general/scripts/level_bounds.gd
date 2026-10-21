@tool 
@icon("res://general/icons/level_bounds.svg")
class_name LevelBounds
extends Node2D

@export_range(480, 2304, 32, "suffic:px") var width : int = 480 : set = _on_width_changed
@export_range(270, 2304, 32, "suffic:px") var height : int = 270 : set = _on_height_changed

@export var set_on_ready : bool = true : set = _on_bool_changed

func _ready() -> void:
	#Set Z-Index so that level bound is on top of  everything else
	z_index = 256
	
	if (Engine.is_editor_hint()) or not set_on_ready:
		return
	
	set_camera_bounds()
	
func set_camera_bounds() -> void:
	#Check for and get reference to camera
	var camera : Camera2D
	
	while not camera:
		await get_tree().process_frame
		camera = get_viewport().get_camera_2d()
	#Updates camera limits
	camera.limit_left = int(global_position.x)
	camera.limit_top = int(global_position.y)
	camera.limit_right = int(global_position.x) + width
	camera.limit_bottom = int(global_position.y) + height

func _draw() -> void:
	if Engine.is_editor_hint():
		# draw a rectangle
		var color_01 : Color = Color(0.0, 0.45, 1, 0.6)
		var color_02 : Color = Color(0.0, 0.75, 1)
		var r : Rect2 = Rect2( Vector2.ZERO, Vector2( width, height) )
		
		if not set_on_ready:
			color_01 = Color(1, 0.302, 0, 0.6)
			color_02 = Color(1, 0.395, 0, 1.0)
			
		draw_rect(r, color_01, false, 3)
		draw_rect(r, color_02, false, 1)

func _on_width_changed( new_width : int ) -> void:
	width = new_width
	queue_redraw()

func _on_height_changed( new_height : int ) -> void:
	height = new_height
	queue_redraw()

func _on_bool_changed( new_value : bool) -> void:
	set_on_ready = new_value
	queue_redraw()
