extends Node3D

@onready var interactable_area: InteractableArea = %InteractableArea
@onready var dialogue_system: CanvasLayer = %DialogueSystem

func _ready() -> void:
	interactable_area.interacted.connect(func(): dialogue_system.start_dialog())
