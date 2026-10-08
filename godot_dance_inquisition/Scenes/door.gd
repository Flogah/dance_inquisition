extends Node3D
class_name Door

signal locked

@onready var door: AnimatableBody3D = $Door
@onready var ia_comp_f: InteractableArea = $IaCompFront
@onready var ia_comp_b: InteractableArea = $IaCompBack
@onready var audio_door: AudioStreamPlayer3D = $AudioDoor

var is_closed: bool = true
var is_moving: bool = false

func _ready() -> void:
	ia_comp_f.interacted.connect(open_close_interaction.bind(true))
	ia_comp_b.interacted.connect(open_close_interaction.bind(false))

func open_close_interaction(front: bool) -> void:
	if not is_moving: play_open_close_audio()
	if is_closed:
		await animate_opening(front)
		is_closed = false
		is_moving = false
	else:
		await animate_closeing()
		is_closed = true
		is_moving = false

func animate_opening(front: bool) -> void:
	print("[Door] opening")
	is_moving = true
	var tween = get_tree().create_tween()
	var dir
	if front:
		dir = 90
	else:
		dir = -90
	tween.set_ease(Tween.EASE_OUT)
	tween.parallel().tween_property(door, "rotation_degrees", Vector3(0, dir, 0), 1.0)
	await tween.finished

func animate_closeing() -> void:
	print("[Door] closeing")
	is_moving = true
	var tween = get_tree().create_tween()
	tween.set_ease(Tween.EASE_OUT)
	tween.parallel().tween_property(door, "rotation_degrees", Vector3(0, 0, 0), 1.0)
	await tween.finished

func play_open_close_audio() -> void:
	audio_door.play();
	audio_door.pitch_scale = randf_range(.6,1.4)
