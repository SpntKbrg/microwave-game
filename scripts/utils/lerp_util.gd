class_name LerpUtil
extends Node

# Exponential Decay
# ref: https://www.youtube.com/watch?v=LSNQuFEDOyQ
# decay_const = rate to transition a to b (range from 1(slow) to 25(fast))

static func exp_decay_vector3(a: Vector3, b: Vector3, decay_const: float, delta: float) -> Vector3:
	return b + (a - b) * exp(-decay_const * delta)
