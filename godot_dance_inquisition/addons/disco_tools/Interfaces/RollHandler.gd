@icon("res://addons/disco_tools/Assets/disco.svg")
# Abstract Class for varous RollUIs. 
# All Methods MUST be overridden.
# Treat this as an interface till GDScript gets traits
@abstract
extends CanvasLayer
class_name RollHandler

# Generally will be async to wait for player input before continuing dialogue
@abstract func rollCheck (check: CheckRes)-> bool

# Make sure this is static
static func getRollOdds(check: CheckRes)-> int:
	assert(false, "ERROR: getRollOdds not implemented!")
	return -1;
