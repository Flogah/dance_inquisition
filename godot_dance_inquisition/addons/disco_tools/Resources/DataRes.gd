@icon("res://addons/disco_tools/Assets/disco.svg")
@tool
extends DiscoRes
class_name DataRes

@export var name: String

@export var value: Variant:
	set(_value):
		value = _value
	get:
		return value

func _init(_name: String = "", _value: Variant =null) -> void:
	name = _name;
	value = _value;

