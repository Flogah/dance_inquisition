@icon("res://addons/disco_tools/Assets/disco.svg")
@tool
extends Node

signal _interactionUpdate

func isInteractable(body: Node, methods: Array[String] = ["interact", "getPrompt", "canInteract"]) -> bool:
	if body == null:
		return false
	# Check for not-interface
	var member: bool = true
	for method in methods:
		if !body.has_method(method):
			member = false
			break

	return member
