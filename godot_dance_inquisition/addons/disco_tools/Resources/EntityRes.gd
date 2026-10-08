@icon("res://addons/disco_tools/Assets/disco.svg")
@tool
extends DiscoRes
class_name EntityRes
# An NPC is talkable but so is a bathroom

@export var name: String

@export var mainDialogue: DialogueResource

@export var image: Image

# checkList is backed by checks. 
@export_storage var checks: Dictionary[String, CheckRes]
@export var checkList: Array[CheckRes]:
	set(value):
		# Add all array values to Dictionary
		var added_keys: Array[String] = []
		for item in value:
			if not item:
				continue
			if item.name == "":
				push_warning("Empty checkList item name found. Object will not be added to backing dictionary.")
				continue

			# Throw error if a duplicate key is found
			assert(not added_keys.has(item.name), "DUPLICATE KEY ERROR: The key '" + item.name + "' exists more than once in checkList. Please pick a unique name.")
			added_keys.append(item.name)
			checks[item.name] = item
		checkList = value
	get: 
		return checkList

@export_storage var events: Dictionary[String, EventRes]
@export var eventList: Array[EventRes]:
	set(value):
		# Add all array values to Dictionary
		var added_keys: Array[String] = []
		for item in value:
			if not item:
				continue
			if item.name == "":
				push_warning("Empty eventList item name found. Object will not be added to backing dictionary.")
				continue

			# Throw error if a duplicate key is found
			assert(not added_keys.has(item.name), "DUPLICATE KEY ERROR: The key '" + item.name + "' exists more than once in eventList. Please pick a unique name.")
			added_keys.append(item.name)
			events[item.name] = item
		eventList = value
	get: 
		return eventList

@export_storage var data: Dictionary[String, DataRes]
@export var dataList: Array[DataRes]:
	set(value):
		# Add all array values to Dictionary
		var added_keys: Array[String] = []
		for item in value:
			if not item:
				continue
			if item.name == "":
				push_warning("Empty dataList item name found. Object will not be added to backing dictionary.")
				continue

			# Throw error if a duplicate key is found
			assert(not added_keys.has(item.name), "DUPLICATE KEY ERROR: The key '" + item.name + "' exists more than once in dataList. Please pick a unique name.")
			added_keys.append(item.name)
			data[item.name] = item
		dataList = value
	get: 
		return dataList

func _init(_name: String = "", _mainDialogue: DialogueResource= null, _image: Image = null, _checks: Dictionary[String, CheckRes] = {}, _checkList: Array[CheckRes] = [], _data: Dictionary[String, DataRes] = {}, _dataList: Array[DataRes] = []) -> void:
	name = _name
	mainDialogue = _mainDialogue
	image = _image
	checks = _checks
	checkList = _checkList
	data = _data
	dataList = _dataList
