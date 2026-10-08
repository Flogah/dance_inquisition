@icon("res://addons/disco_tools/Assets/disco.svg")
extends Control
class_name DevUI

func _ready() -> void:
	if !get_tree().root.has_node("DiscoDevtools"):
		hide()

func ItemSelected(selection: int):
	# Thanks to dragonforge-dev for the helpful solution here
	# https://forum.godotengine.org/t/how-to-define-behavior-for-disabled-autoload/137723/2

	var disco_dev_tools: Variant = get_tree().root.get_node("DiscoDevtools")
	disco_dev_tools.set("DEV_force_check_state", selection);
