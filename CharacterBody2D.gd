extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var CHARGE = 0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var animation_player = $AnimatedSprite2D

var bullet_path = preload("res://bullet.tscn")

func _physics_process(delta):
	$Label.text = "Charge: " + str(CHARGE)
	$Gun.look_at(get_global_mouse_position())
	#look_at(get_global_mouse_position())
	if Input.is_action_pressed("ui_accept"):
		if CHARGE < 100:
			CHARGE += 1
	if Input.is_action_just_released("ui_accept"):
		fire(CHARGE)
		CHARGE = 0
		
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		if velocity.y > 0:
			animation_player.play("fall")
		else:
			animation_player.play("Jump")

	# Handle Jump.
	if Input.is_action_just_pressed("ui_up") and is_on_floor():
		velocity.y = JUMP_VELOCITY


	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	animation_player.flip_h = 0 > direction if direction else animation_player.flip_h
	if direction:
		velocity.x = direction * SPEED
		if is_on_floor():
			animation_player.play("run")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if is_on_floor():
			animation_player.play("idle")

	move_and_slide()

func fire(Charge:int):
	var bullet = bullet_path.instantiate()
	bullet.initial_Speed *= float(Charge)/100
	bullet.pos = $Gun.global_position + Vector2(16,0).rotated($Gun.rotation)
	bullet.rota = $Gun.global_rotation
	get_parent().add_child(bullet)
