extends ScrollContainer

@onready var dialogue_container: VBoxContainer = %DialogueContainer

func _ready() -> void:
	call_deferred("scroll_to_last")

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("next_step"):
		add_text()

func scroll_to_last() -> void:
	var max_val = get_v_scroll_bar().max_value
	set_deferred("scroll_vertical", max_val)

func add_text(speaker:String = "Unknown", text:String = "..."):
	var format_string:String = "{spkr}: {txt}"
	var new_text:String = format_string.format({"spkr": speaker, "txt": text})
	
	var new_label:Label = Label.new()
	new_label.text = new_text
	dialogue_container.add_child(new_label)
	call_deferred("scroll_to_last")
