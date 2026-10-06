extends CanvasLayer

@onready var scroll_container: ScrollContainer = %ScrollContainer

func add_dialogue_choices():
	pass

func display_speech(actor:String, text:String):
	scroll_container.add_text(actor, text)
