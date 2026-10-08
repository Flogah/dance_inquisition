@icon("res://addons/disco_tools/Assets/disco.svg")
@tool
extends DiscoRes
class_name MissionRes

@export var name: String

# eventList is backed by events. 
@export_storage var events: Dictionary[String, EventRes]
@export var eventList: Array[EventRes]:
	set(value):
		# Add all array values to Dictionary
		var added_keys: Array[String] = []
		for item in value:
			if not item:
				continue
			item.mission = weakref(self);
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

@export var status: DiscoTools.EMissionStatus

# Setting status string to anything other than ""
#will automatically mark the mission status as OTHER
@export var statusString: String:
	set(value):
		if value != "":
			status = Disco.EMissionStatus.OTHER
		statusString = value
	get:
		return statusString

# TODO: Support StatusString in completion checking
# Automatically sets mission status to success when all events are Successes
func checkComplete() -> void:
	if !(status == Disco.EMissionStatus.NOT_OFFERED or status == Disco.EMissionStatus.IN_PROGRESS):
		return
	for event in eventList:
		if (event.optional):
			continue
		if (event.status != Disco.EEventStatus.SUCCESS):
			return
	status = Disco.EMissionStatus.SUCCESS

func _init(_name: String = "", _events: Dictionary[String, EventRes] = {}, _eventList: Array[EventRes] = [], _data: Dictionary[String, DataRes] = {}, _dataList: Array[DataRes] = [], _status = 0, _statusString: String = "") -> void:
	name = _name
	events = _events
	eventList = _eventList
	data = _data
	dataList = _dataList
	status = _status
	statusString = _statusString
