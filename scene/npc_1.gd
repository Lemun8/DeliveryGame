extends Area2D

# The list of items that the NPC can request
var items = ["Item1", "Item2", "Item3", "Item4"]

# Variable to store the requested item
var requested_item = null
var player_in_range = false
@onready var player = get_node("/root/Game/Player")
@onready var item_deliver = $"Item Deliver"
@export var NPC_name : String
@export var item_label : Label
@export var expulsion : CPUParticles2D

func _ready():
	request_random_item()

func request_random_item():
	requested_item = items[randi() % items.size()]
	item_label.text = str(requested_item)
	print(NPC_name, "is requesting: ", requested_item)

func check_item():
	if player and player.current_item == requested_item:
		print("Correct item delivered!")
		request_random_item()  # NPC requests a new item after receiving the correct one
		player.current_item = ""  # The player gives the item to the NPC
		player.item_label.text = str(player.current_item)
		expulsion.emitting = true
		ScoreManager.add_score()
		item_deliver.play()
	else:
		print("Wrong item or no item to deliver!", NPC_name, "is still requesting: ", requested_item)

func _on_body_entered(body):
	if body.is_in_group("Player"):
		player_in_range = true

func _on_body_exited(body):
	if body.is_in_group("Player"):
		player_in_range = false

func _process(delta):
	if player_in_range and Input.is_action_just_pressed("interact"):
		check_item()
