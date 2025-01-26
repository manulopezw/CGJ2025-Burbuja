extends CharacterBody2D

var pos:Vector2
var rota:float
var MAX_SPEED = 1500
var initial_Speed:float = 1500
var speed:float 

func _ready() -> void:
	global_position = pos
	global_rotation = rota
	speed = initial_Speed
	var proportion = 0.3+0.7*(1-(speed/initial_Speed))*(2*(initial_Speed/MAX_SPEED))
	scale = Vector2(proportion,proportion)

func _physics_process(delta: float) -> void:
	velocity = Vector2(speed,0).rotated(rota)
	var proportion = 0.3+0.7*(1-(speed/initial_Speed))*(2*(initial_Speed/MAX_SPEED))
	if proportion>0.5:
		$EstadoSolido.disabled = false
	scale = Vector2(proportion,proportion)

	if speed > 0:
		speed -= (speed/initial_Speed)*100*randf_range(0.8,1.2)
	
	if speed < 1:
		speed = 0
		
	move_and_slide()


func _on_timer_timeout() -> void:
	$AnimatedSprite2D.play('explode')
	$AudioStreamPlayer.play()


func _on_area_2d_body_entered(body: Node2D) -> void:
	print("bala choca " + body.name)
	
	if body.name != name:
		var proportion = 0.3+0.7*(1-(speed/initial_Speed))*(2*(initial_Speed/MAX_SPEED))
		print('escala ' + str(proportion))
		if body.name == 'Jugador' && proportion>0.5:
			print('no exploto')
			return
		else:
			print('exploto')
			$AnimatedSprite2D.play('explode')
			$AudioStreamPlayer.play()
			


func _on_animated_sprite_2d_animation_finished() -> void:
	if $AnimatedSprite2D.animation == 'explode':
		
		queue_free()
