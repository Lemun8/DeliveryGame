extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("pause"):
		visible = !visible
		get_tree().paused = !get_tree().paused


func _on_resume_pressed():
	get_tree().paused = false
	visible = false


func _on_main_menu_pressed():
	ScoreManager.reset_score()
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scene/menu.tscn")
