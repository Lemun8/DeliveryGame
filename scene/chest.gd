extends Area2D


# The list of items that the player can receive
var items = ["Item1", "Item2", "Item3", "Item4"]

# A reference to the player (can be set via the editor or dynamically)
@onready var player = get_node("/root/Game/Player")
@onready var item_pickup = $"Pickup Item"
@onready var drop_item = $"Drop Item"
# Boolean to check if the player is inside the collider
var player_inside = false
var current_item = ""
# Function to randomly select an item
func give_random_item():
	if player.current_item == "":
		var random_item = items[randi() % items.size()]
		player.current_item = random_item
		print("You received: ", random_item)
	else:
		print("Cannot hold more than one item")

func remove_current_item():
	if player.current_item:
		print("Item removed: ", player.current_item)
		drop_item.play()
		player.current_item = ""
	else:
		print("No item to remove")

# _process function runs every frame
func _process(delta):
	if player_inside and Input.is_action_just_pressed("take"):
		give_random_item()
		item_pickup.play()
	if Input.is_action_just_pressed("remove"):  # Assuming "remove_item" is mapped to G
		remove_current_item()
		player.item_label.text = str(player.current_item)

func _on_body_entered(body):
	print("inside")
	if body.is_in_group("Player"):
		player_inside = true
		player = body

func _on_body_exited(body):
	print("outside")
	if body.is_in_group("Player"):
		player_inside = false
		#player = null

