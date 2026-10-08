@icon("res://addons/disco_tools/Assets/disco.svg")
@tool
extends DiscoRes
class_name StateRes

@export_storage var rollResult: bool

@export var rollHandler: PackedScene:
	set(value):
		if value != null:
			var target = value.instantiate()
			if target is RollHandler:
				handlerScript = target.get_script()
			target.queue_free()
		rollHandler = value

	get:
		return rollHandler

@export_storage var handlerScript: Script

# eventList is backed by events
@export_storage var events: Dictionary[String, EventRes]
@export var eventList: Array[EventRes]:
	set(value):
		# Add all array values to Dictionary
		var added_keys: Array[String] = []
		for item in value:
			if not item:
				continue
			if item.name == "":
				push_warning("Empty EventList item name found. Object will not be added to backing dictionary.")
				continue

			# Throw error if a duplicate key is found
			assert(not added_keys.has(item.name), "DUPLICATE KEY ERROR: The key '" + item.name + "' exists more than once in EventList. Please pick a unique name.")
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

# missionList is backed by missions
@export_storage var missions: Dictionary[String, MissionRes]
@export var missionList: Array[MissionRes]:
	set(value):
		# Add all array values to Dictionary
		var added_keys: Array[String] = []
		for item in value:
			if not item:
				continue
			if item.name == "":
				push_warning("Empty MissionList item name found. Object will not be added to backing dictionary.")
				continue

			# Throw error if a duplicate key is found
			assert(not added_keys.has(item.name), "DUPLICATE KEY ERROR: The key '" + item.name + "' exists more than once in MissionList. Please pick a unique name.")
			added_keys.append(item.name)
			missions[item.name] = item
		missionList = value
	get: 
		return missionList

@export_storage var entities: Dictionary[String, EntityRes]
@export var entityList: Array[EntityRes]:
	set(value):
		# Add all array values to Dictionary
		var added_keys: Array[String] = []
		for item in value:
			if not item:
				continue
			if item.name == "":
				push_warning("Empty EntityList item name found. Object will not be added to backing dictionary.")
				continue

			# Throw error if a duplicate key is found
			assert(not added_keys.has(item.name), "DUPLICATE KEY ERROR: The key '" + item.name + "' exists more than once in EntityList. Please pick a unique name.")
			added_keys.append(item.name)
			entities[item.name] = item
		entityList = value
	get: 
		return entityList

@export_storage var playerChecks: Dictionary[String, CheckRes]
@export var playerCheckList: Array[CheckRes]:
	set(value):
		# Add all array values to Dictionary
		var added_keys: Array[String] = []
		for item in value:
			if not item:
				continue
			if item.name == "":
				push_warning("Empty playerCheckList item name found. Object will not be added to backing dictionary.")
				continue

			# Throw error if a duplicate key is found
			assert(not added_keys.has(item.name), "DUPLICATE KEY ERROR: The key '" + item.name + "' exists more than once in playerCheckList. Please pick a unique name.")
			added_keys.append(item.name)
			playerChecks[item.name] = item
		playerCheckList = value
	get: 
		return playerCheckList

func _init(_events: Dictionary[String, EventRes] = {}, _eventList: Array[EventRes] = [], _missions: Dictionary[String, MissionRes] = {}, _missionList: Array[MissionRes] = [], _entities: Dictionary[String, EntityRes] = {}, _entityList: Array[EntityRes] = [],_data: Dictionary[String, DataRes] = {}, _dataList: Array[DataRes] = [], _rollHandler: PackedScene = null, _handlerScript: Script = null, _rollResult: bool = false) -> void:
	events = _events
	eventList = _eventList
	data = _data
	dataList = _dataList
	missions = _missions
	missionList = _missionList
	entities = _entities
	entityList = _entityList
	rollHandler = _rollHandler
	handlerScript = _handlerScript
	rollResult = _rollResult

