extends Node

var score = 0
var highscore = 0
var save_path = "user://score.save"
@export var score_label : Label

func add_score():
	score += 1
	score_label.text = "Score: " + str(score)

func save_score():
	var file = FileAccess.open(save_path, FileAccess.WRITE)
	file.store_var(highscore)


func load_score():
	if FileAccess.file_exists(save_path):
		print("file found")
		var file = FileAccess.open(save_path, FileAccess.READ)
		highscore = file.get_var()
	else:
		print("file not found")
		highscore = 0

func set_highscore():
	highscore = score

func reset_score():
	score = 0
	score_label.text = "Score: " + str(score)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
