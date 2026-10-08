@icon("res://addons/disco_tools/Assets/disco.svg")
@tool
extends CheckRes
class_name DefaultCheckRes

@export var name: String
@export var oneshot: bool
@export var passive: bool

@export var difficulty: int

# eventList is backed by checks. 
@export_storage var modifiers: Dictionary[String, DefaultModRes]
@export var modList: Array[DefaultModRes]:
	set(value):
		# Add all array values to Dictionary
		var added_keys: Array[String] = []
		for item in value:
			if not item:
				continue
			if item.name == "":
				push_warning("Empty defaultModList item name found. Object will not be added to backing dictionary.")
				continue

			# Throw error if a duplicate key is found
			assert(not added_keys.has(item.name), "DUPLICATE KEY ERROR: The key '" + item.name + "' exists more than once in defaultModList. Please pick a unique name.")
			added_keys.append(item.name)
			modifiers[item.name] = item
		modList = value
	get: 
		return modList


@export_storage var attempts: int

@export_storage var locked: bool
@export_storage var passed: bool

func to_bool() -> bool:
	return passed

func _init(_name: String = "", _modifiers: Dictionary[String, DefaultModRes] = {}, _modList: Array[DefaultModRes] = [], _oneshot: bool = false, _difficulty: int = 0, _attempts: int = 0, _locked: bool = false, _passed: bool = false) -> void:
	name = _name
	modifiers = _modifiers
	modList = _modList
	oneshot = _oneshot
	difficulty = _difficulty
	attempts = _attempts
	locked = _locked
	passed = _passed
