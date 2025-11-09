class_name ItemScene
extends Node3D

@export_group("Internal")
@export var item_holder: Node3D
@export var item_rot_target: Node3D

@export_group("Adjustables")
@export_range(1, 25) var rotation_const: float
@export var rotate_speed: float = 1.0

var is_label_placed := false

func _process(delta: float) -> void:
	__do_rotate_obj(delta)


func _physics_process(_delta: float) -> void:
	if not is_label_placed:
		get_item_surface_point()
		is_label_placed = true

func __do_rotate_obj(delta: float) -> void:
	var current = item_holder.rotation_degrees
	var target = item_rot_target.rotation_degrees
	if (current - target).is_zero_approx():
		return
	# rotate item towards target
	item_holder.rotation_degrees = LerpUtil.exp_decay_vector3(current, target, rotation_const, delta)
	print(item_holder.rotation_degrees)


func __do_set_item() -> void:
	# remove current item
	for item in item_holder.get_children():
		item.queue_free()
	# spawn new item


func add_rotation(to_add: Vector3) -> void:
	item_rot_target.rotation_degrees += Vector3(to_add.y, to_add.x, 0) * rotate_speed


func reset_rotation() -> void:
	item_rot_target.rotation = Vector3.ZERO
	item_holder.rotation = Vector3.ZERO


# call in physics_process only
func get_item_surface_point() -> Array[Vector3]:
	var sphere_point := RandUtil.rand_point_on_sphere(10)
	var ray_param := PhysicsRayQueryParameters3D.create(sphere_point, Vector3.ZERO)
	ray_param.collide_with_bodies = true
	var space_state := get_world_3d().direct_space_state
	var result := space_state.intersect_ray(ray_param)
	var item_pos := Vector3.ZERO
	var item_normal := Vector3.UP
	if result:
		item_pos = result.get("position")
		item_normal = result.get("normal")
	return [item_pos, item_normal]
	
