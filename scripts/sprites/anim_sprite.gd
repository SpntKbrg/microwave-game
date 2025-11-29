class_name AnimSprite
extends AnimatedSprite2D



@export_category("Internal")
@export var __particles: GPUParticles2D


var __is_animating: bool = false
var __is_particle_emitting: bool = false

func set_animating(is_animating: bool) -> void:
	__is_animating = is_animating
	__is_particle_emitting = is_animating
	__update_display()


func __update_display() -> void:
	if __is_animating:
		play()
	else:
		stop()

	if __particles != null:
		__particles.emitting = __is_particle_emitting
