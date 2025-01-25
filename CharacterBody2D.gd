extends CharacterBody2D


var SPEED = 100.0
var JETPACK_SPEED = 25 #25
var FUEL = 1
var JETPACK_ON = false

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var animation_player = $AnimatedSprite2D


func _physics_process(delta):
	$"fuelLabel".text = "FUEL: " + str(FUEL)
	velocity.y += gravity * delta
	# Handle Jetpack.
	if Input.is_action_pressed("ui_up") && is_on_floor() && FUEL < 50:
		#Cargamos FUEL
		FUEL += 1
	if Input.is_action_just_released("ui_up"):
		JETPACK_ON = true
	if JETPACK_ON && FUEL > 0:
		velocity.y -= JETPACK_SPEED
		FUEL -= 1
		$"Jetpack Bubbles/CPUParticles2D".emitting = true
	else:
		JETPACK_ON = false
		$"Jetpack Bubbles/CPUParticles2D".emitting = false		

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
