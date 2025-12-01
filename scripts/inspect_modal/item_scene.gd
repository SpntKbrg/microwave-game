class_name ItemScene
extends Node3D

@export_group("Internal")
@export var __item_holder: Node3D
@export var __item_rot_target: Node3D
@export var __sticker: Sprite3D
@export var __sticker_texture: Sticker

@export_group("Adjustables")
@export_range(1, 25) var rotation_const: float
@export var rotate_speed: float = 1.0

var __is_label_placed := false

func _process(delta: float) -> void:
	__do_rotate_obj(delta)

func _physics_process(_delta: float) -> void:
	if not __is_label_placed:
		var sticker_placement := __get_item_surface_point()
		__sticker.position = sticker_placement[0] - (sticker_placement[1] * 0.001)
		__sticker.look_at(sticker_placement[0] + sticker_placement[1])
		__sticker.rotation_degrees.z = randf_range(-180, 180)
		__is_label_placed = true

func __do_rotate_obj(delta: float) -> void:
	var current = __item_holder.rotation_degrees
	var target = __item_rot_target.rotation_degrees
	if (current - target).is_zero_approx():
		return
	# rotate item towards target
	__item_holder.rotation_degrees = LerpUtil.exp_decay_vector3(current, target, rotation_const, delta)


func add_rotation(to_add: Vector3) -> void:
	__item_rot_target.rotation_degrees += Vector3(to_add.y, to_add.x, 0) * rotate_speed

func set_target_rotation(to_set: Vector3) -> void:
	__item_rot_target.rotation_degrees = to_set

func reset_rotation() -> void:
	__item_rot_target.rotation = Vector3.ZERO
	__item_holder.rotation = Vector3.ZERO

func get_target_rotation() -> Vector3:
	return __item_rot_target.rotation_degrees

func set_sticker_text(text: String) -> void:
	__sticker_texture.set_label(text)

func set_item_model(model: PackedScene) -> void:
	var item_model = model.instantiate();
	__item_holder.add_child(item_model);

# call in physics_process only
func __get_item_surface_point() -> Array[Vector3]:
	var item_pos := Vector3.ZERO
	var item_normal := Vector3.UP
	while 1:
		var sphere_point := RandUtil.rand_point_on_sphere(10)
		var inside_point := RandUtil.rand_point_in_circle(1)
		var ray_param := PhysicsRayQueryParameters3D.create(
			sphere_point,
			Vector3(inside_point.x, inside_point.y, 0)
		)
		ray_param.collide_with_bodies = true
		var space_state := get_world_3d().direct_space_state
		var result := space_state.intersect_ray(ray_param)

		if result:
			item_pos = result.get("position")
			item_normal = -result.get("normal")
			break
	return [item_pos, item_normal]
