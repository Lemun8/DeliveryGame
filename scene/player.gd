extends CharacterBody2D


const SPEED = 130.0
const JUMP_VELOCITY = -300.0
@export var player_animation : AnimatedSprite2D
@export var item_label : Label
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var current_item = ""
var nearby_npc = null

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		player_animation.play("walk")
		if direction < 0:
			player_animation.flip_h = true
		else:
			player_animation.flip_h = false
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	item_label.text = str(current_item)

func _on_area_2d_body_entered(body):
	if body.is_in_group("NPC"):
		nearby_npc = body

func _on_area_2d_body_exited(body):
	if body.is_in_group("NPC"):
		nearby_npc = null

#func _process(delta):
	#print(current_item)
