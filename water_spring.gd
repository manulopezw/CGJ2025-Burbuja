extends Node2D

var velocity = 0;
var force = 0;
var height = 0; # current height of the spring
var target_height = 0; # natural position of the spring

@onready var collision = $Area2D/CollisionShape2D;

var index = 0

var motion_factor = 0.02

var colided_with = null

signal splash

func water_update(spring_constant, dampening):
	height = position.y;
	var x = height - target_height;
	var loss = -dampening * velocity;
	force = -spring_constant * x + loss;
	velocity += force;
	position.y += velocity;
	pass
	
func initialize(x_position, id):
	height = position.y;
	target_height = position.y;
	velocity = 0;
	position.x = x_position;
	index = id
	
func set_collision_width(value):
	var extents = collision.shape.get_size()
	var new_extents = Vector2(value/2, extents.y)
	collision.shape.set_size(new_extents)
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "TileMapLayer":
		return
	if body == colided_with:
		return
	colided_with = body
	print("GAME OVER")
	var speed = body.velocity.y * motion_factor
	emit_signal("splash",index,speed)
	body.velocity = body.velocity * 0.1
	body.gravity *= 0.1
	pass # Replace with function body.
