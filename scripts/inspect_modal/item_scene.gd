class_name ItemScene
extends Node3D

@export_group("Internal")
@export var item_holder: Node3D
@export var item_rot_target: Node3D
@export var sticker: Sprite3D
@export var sticker_texture: Sticker

@export_group("Adjustables")
@export_range(1, 25) var rotation_const: float
@export var rotate_speed: float = 1.0

var is_label_placed := false

func _process(delta: float) -> void:
	__do_rotate_obj(delta)


func _physics_process(_delta: float) -> void:
	if not is_label_placed:
		var sticker_placement := get_item_surface_point()
		sticker.position = sticker_placement[0] - (sticker_placement[1] * 0.001)
		sticker.look_at(sticker_placement[0] + sticker_placement[1])
		sticker.rotation_degrees.z = randf_range(-180, 180)
		is_label_placed = true

func __do_rotate_obj(delta: float) -> void:
	var current = item_holder.rotation_degrees
	var target = item_rot_target.rotation_degrees
	if (current - target).is_zero_approx():
		return
	# rotate item towards target
	item_holder.rotation_degrees = LerpUtil.exp_decay_vector3(current, target, rotation_const, delta)


func __do_set_item() -> void:
	# remove current item
	for item in item_holder.get_children():
		item.queue_free()
	# spawn new item


func add_rotation(to_add: Vector3) -> void:
	item_rot_target.rotation_degrees += Vector3(to_add.y, to_add.x, 0) * rotate_speed

func set_target_rotation(to_set: Vector3) -> void:
	item_rot_target.rotation_degrees = to_set

func reset_rotation() -> void:
	item_rot_target.rotation = Vector3.ZERO
	item_holder.rotation = Vector3.ZERO

func get_target_rotation() -> Vector3:
	return item_rot_target.rotation_degrees

func set_sticker_text(text: String) -> void:
	sticker_texture.set_label(text)

# call in physics_process only
func get_item_surface_point() -> Array[Vector3]:
	var sphere_point := RandUtil.rand_point_on_sphere(10)
	var inside_point := RandUtil.rand_point_in_circle(1)
	var ray_param := PhysicsRayQueryParameters3D.create(
		sphere_point,
		Vector3(inside_point.x, inside_point.y, 0)
	)
	ray_param.collide_with_bodies = true
	var space_state := get_world_3d().direct_space_state
	var result := space_state.intersect_ray(ray_param)
	var item_pos := Vector3.ZERO
	var item_normal := Vector3.UP
	if result:
		item_pos = result.get("position")
		item_normal = -result.get("normal")
	return [item_pos, item_normal]
