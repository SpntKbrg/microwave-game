class_name RandUtil
extends Node

static func rand_point_on_sphere(radius: float = 1) -> Vector3: 
	var x := randf_range(-1, 1)
	var y := randf_range(-1, 1)
	var z := randf_range(-1, 1)
	if (x == 0 and y == 0 and z == 0):
		y = 1

	return radius / sqrt(pow(x, 2) + pow(y, 2) + pow(z, 2)) * Vector3(x, y, z)


static func rand_point_in_circle(radius: float = 1) -> Vector2:
	var base := Vector2.from_angle(randf_range(0, 2 * PI))
	var size := randf_range(0, radius)
	return base * size
