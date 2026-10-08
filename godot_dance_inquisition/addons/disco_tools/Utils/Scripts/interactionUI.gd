
extends Control

@onready var prompt: Label = %InteractionPrompt

func _enter_tree() -> void:	
	DiscoUtils._interactionUpdate.connect(setInteraction);

func setInteraction(newItem:Node) :
	# DO NOT TRY TO PASS A NON-IINTERACTABLE NODE WITH ENABLED=TRUE
	# Check for iinteractable
	if (!DiscoUtils.isInteractable(newItem)):
		prompt.hide();
		return;
	prompt.text = "Tap E to " + newItem.getPrompt();
	prompt.show();
