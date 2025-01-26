extends CanvasLayer

@onready var player = $"../Jugador"

var score = 0  # Puntaje actual
var max_score = 0  # Puntaje máximo alcanzado
var initial_position = 0  # Empezamos en la posición 0 para el puntaje

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	score = 0  # Inicializamos el score en 0
	max_score = 0  # Inicializamos el score máximo en 0
	initial_position = Vector2(320,360)  # La posición inicial para que empiece el puntaje

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	print(player.position.y)
	# Si el jugador ha ascendido desde la posición 0, empieza a contar el puntaje
	score =  round(initial_position.distance_to(player.global_position) / 100 )
		# Si el puntaje actual es mayor que el puntaje máximo, lo actualizamos
	if score > max_score:
		max_score = score

	# Actualizamos las etiquetas de la UI
	$JetPackLabel.text = "Fuel: " + str(player.FUEL)
	$GunLabel.text = "Charge: " + str(player.CHARGE)
	$ScoreLabel.text = "Score: " + str(score)  # Muestra el puntaje actual
	$MaxScoreLabel.text = "Max Score: " + str(max_score)  # Muestra el puntaje máximo alcanzado

	# Actualizamos las barras de energía
	$JetPackBar.value = player.FUEL
	$GunBar.value = player.CHARGE
