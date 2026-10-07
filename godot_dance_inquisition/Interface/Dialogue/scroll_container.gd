extends ScrollContainer

signal choice_selected(number)

@onready var dialogue_container: VBoxContainer = %DialogueContainer

func _ready() -> void:
	call_deferred("scroll_to_last")

#func _input(event: InputEvent) -> void:
	#if event.is_action_pressed("next_step"):
		#add_text()

func scroll_to_last() -> void:
	var max_val = get_v_scroll_bar().max_value
	set_deferred("scroll_vertical", max_val)

func add_dialogue_text(speaker:String = "Unknown", text:String = "..."):
	var format_string:String = "{spkr}: {txt}"
	var new_text:String = format_string.format({"spkr": speaker, "txt": text})
	create_rich_label(new_text)

func create_rich_label(text:String) -> RichTextLabel:
	var new_label:RichTextLabel = RichTextLabel.new()
	new_label.bbcode_enabled = true
	new_label.fit_content = true
	new_label.text = text
	dialogue_container.add_child(new_label)
	call_deferred("scroll_to_last")
	return new_label

func add_choices(choice_dict:Dictionary):
	var new_vbox:VBoxContainer = VBoxContainer.new()
	dialogue_container.add_child(new_vbox)
	for num in choice_dict.size():
		var new_button:Button = Button.new()
		new_button.text = choice_dict[num+1]
		new_button.pressed.connect(func(): choice_selected.emit(num+1))
		new_vbox.add_child(new_button)
