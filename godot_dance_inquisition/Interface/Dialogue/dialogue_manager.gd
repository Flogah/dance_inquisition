extends CanvasLayer

#@onready var scroll_container: ScrollContainer = %ScrollContainer
@onready var main_control: Control = %MainControl
@onready var dialog_player: DialogPlayer = %DialogPlayer

var disappear_distance:Vector2 = Vector2(50.0, 0.0)
var anim_duration:float = 0.5

var example_choice_dict:Dictionary = {
	1: "Option 1.",
	2: "Option 2."
}

func _ready() -> void:
	set_visibility(false)
	##scroll_container.choice_selected.connect(use_choice)

func start_dialog():
	set_visibility(true)
	dialog_player.start()

func use_choice(choice):
	print(choice)

func set_visibility(b:bool):
	if b:
		main_control.modulate = Color(1.0, 1.0, 1.0, 1.0)
		main_control.position = Vector2.ZERO
		visible = true
	else:
		main_control.modulate = Color(1.0, 1.0, 1.0, 0.0)
		main_control.position = disappear_distance
		visible = false

func appear():
	# set visible first, might be replaced with processing
	visible = true
	
	var appear_tween:Tween = create_tween()
	appear_tween.set_parallel()
	appear_tween.tween_property(main_control, "modulate", Color(1.0, 1.0, 1.0, 1.0), anim_duration)
	appear_tween.tween_property(main_control, "position", Vector2(0.0, 0.0), anim_duration)

func disappear():
	var disappear_tween:Tween = create_tween()
	disappear_tween.set_parallel()
	disappear_tween.tween_property(main_control, "modulate", Color(1.0, 1.0, 1.0, 0.0), anim_duration)
	disappear_tween.tween_property(main_control, "position", disappear_distance, anim_duration)
	
	# make the dialogue officially invisible
	# maybe not necessary, as the dialogue is already alphad out?
	# maybe saves perf
	disappear_tween.finished.connect(func(): visible = false)
