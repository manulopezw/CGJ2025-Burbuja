extends CanvasLayer

@onready var player = $"../Jugador"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$JetPackLabel.text = "Fuel: " + str(player.FUEL)
	$GunLabel.text = "Charge: " + str(player.CHARGE)
	$JetPackBar.value =  player.FUEL
	$GunBar.value =  player.CHARGE
