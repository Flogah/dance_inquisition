extends Node2D

@export var dialogue: DialogueResource

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	DialogueManager.show_dialogue_balloon(dialogue, "start")
