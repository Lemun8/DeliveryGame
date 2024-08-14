extends Node2D

@export var timer_label : Label
@export var timer : Timer

func _ready():
	ScoreManager.score_label.visible = true
	

func _process(delta):
	if timer.time_left > 0:
		timer_label.text = str(int(timer.time_left))
	


func _on_game_timer_timeout():
	$GameOver.visible = true
	get_tree().paused = true
	if ScoreManager.score > ScoreManager.highscore:
		ScoreManager.set_highscore()
		ScoreManager.save_score()
