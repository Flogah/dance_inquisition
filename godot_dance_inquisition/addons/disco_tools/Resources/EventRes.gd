@icon("res://addons/disco_tools/Assets/disco.svg")
@tool
extends DiscoRes
class_name EventRes

@export var name: String

@export_storage var mission: WeakRef

@export var status: DiscoTools.EEventStatus:
	set(value):
		status = value
		if (mission != null):
			if (mission.get_ref() != null):
				mission.get_ref().checkComplete()
	get:
		return status

# Setting status string to anything other than ""
#will automatically mark the event status as OTHER
@export var statusString: String:
	set(value):
		if value != "":
			status = Disco.EEventStatus.OTHER
		statusString = value
	get:
		return statusString

@export var optional: bool

func _init(_name: String = "", _optional:bool = false, _mission: WeakRef= null, _status = 0, _statusString: String = "") -> void:
	name = _name;
	status = _status
	optional = _optional
	mission = _mission
	statusString = _statusString

# Ensures the "optional"" property is only shown when the object is a child of a mission.
func _validate_property(property: Dictionary):
	if property.name == "optional" and mission == null:
		property.usage = PROPERTY_USAGE_NO_EDITOR
