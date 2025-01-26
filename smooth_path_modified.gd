class_name SmoothPath
extends Path2D

@export var spline_length: int = 8
@export var _smooth: bool = false
@export var _straighten: bool = false
@export var color: Color = Color(1, 1, 1, 1)
var width: int = 8

# Setter y getter para _smooth
func set_smooth(value: bool) -> void:
	_smooth = value
	smooth(value)

func get_smooth() -> bool:
	return _smooth

# Setter y getter para _straighten
func set_straighten(value: bool) -> void:
	_straighten = value
	straighten(value)

func get_straighten() -> bool:
	return _straighten

# Endereza los puntos de la curva
func straighten(value: bool) -> void:
	if not value:
		return
	for i in range(curve.get_point_count()):
		curve.set_point_in(i, Vector2.ZERO)
		curve.set_point_out(i, Vector2.ZERO)

# Suaviza los puntos de la curva
func smooth(value: bool) -> void:
	if not value:
		return

	var point_count = curve.get_point_count()
	for i in range(point_count):
		if i > 0 and i < point_count - 1:
			var spline = _get_spline(i)
			curve.set_point_in(i, -spline)
			curve.set_point_out(i, spline)

# Calcula el spline de un punto específico
func _get_spline(i: int) -> Vector2:
	var last_point = _get_point(i - 1)
	var next_point = _get_point(i + 1)
	return last_point.direction_to(next_point) * spline_length

# Obtiene la posición de un punto, manejando el wrap-around
func _get_point(i: int) -> Vector2:
	var point_count = curve.get_point_count()
	i = wrapi(i, 0, point_count)
	if i > 1 and i < point_count - 1:
		return curve.get_point_position(i)
	elif i <= 1:
		return Vector2(curve.get_point_position(1).x - spline_length, curve.get_point_position(1).y)
	elif i >= point_count - 1:
		return Vector2(curve.get_point_position(point_count - 1).x + spline_length, curve.get_point_position(point_count - 1).y)
	else:
		return Vector2(Vector2(curve.get_point_position(point_count - 1).x + spline_length, curve.get_point_position(point_count - 1).y))
# Dibuja la curva
func _draw() -> void:
	var points = curve.get_baked_points()
	if points:
		draw_polyline(points, color, width, true)
