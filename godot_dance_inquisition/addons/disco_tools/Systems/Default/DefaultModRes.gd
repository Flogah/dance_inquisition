@icon("res://addons/disco_tools/Assets/disco.svg")
@tool
extends DiscoRes
class_name DefaultModRes

@export var name: String 

@export var bonus: int

@export var enabled: bool

func _init(_name: String = "", _bonus: int = 0, _enabled: bool = false): 
	name = _name
	bonus = _bonus
	enabled = _enabled
