@icon("res://addons/disco_tools/Assets/disco.svg")
@tool
extends Node
class_name DiscoTools

const SAVE_PATH: String = "user://disco_state.res"
const INIT_PATH: String = "user://disco_state_init.res"

@export var state:StateRes

var entities: Dictionary[String, EntityRes]:
	set(value):
		state.entities = value
	get:
		return state.entities

var missions: Dictionary[String, MissionRes]:
	set(value):
		state.missions = value
	get:
		return state.missions

var events: Dictionary[String, EventRes]:
	set(value):
		state.events = value
	get:
		return state.events

var data: Dictionary[String, DataRes]:
	set(value):
		state.data = value

	get:
		return state.data


var playerChecks: Dictionary[String, CheckRes]:
	set(value):
		state.playerChecks = value
	get:
		return state.playerChecks

var rollResult: bool:
	set(value):
		state.rollResult = value
	get:
		return state.rollResult

var currentHandler: RollHandler

# FUNCTIONS

func _ready() -> void:
	save_state(INIT_PATH)

func resetState() -> void:
	load_state(INIT_PATH)

func save_state(path: String = SAVE_PATH) -> void:
	ResourceSaver.save(state, path)

func load_state(path: String = SAVE_PATH) -> void:
	state = ResourceLoader.load(path)
	

func boolEntityCheck(entity: String, check:String) -> bool:
	return entities[entity].checks[check].to_bool()

func boolPlayerCheck(check:String) -> bool:
	return playerChecks[check].to_bool()

func getData(key: String) -> Variant:
	return data[key].value

func setData(key: String, value:Variant) -> void:
	data[key].value = value;

func boolEventStatus(event: String, status:EEventStatus = EEventStatus.SUCCESS, statusStr: String = "") -> bool:
	if (statusStr != ""):
		return events[event].statusString == statusStr
	return events[event].status == status

func boolMissionStatus(mission: String, status:EMissionStatus = EMissionStatus.SUCCESS, statusStr: String = "") -> bool:
	if (statusStr != ""):
		return missions[mission].statusString == statusStr
	return missions[mission].status == status

func boolMissionEventStatus(mission: String, event: String, status:EEventStatus = EEventStatus.SUCCESS, statusStr: String = "") -> bool:
	if (statusStr != ""):
		return missions[mission].events[event].statusString == statusStr
	return missions[mission].events[event].status == status


func rollPlayer(check:String) -> bool:
	return await roll(playerChecks[check])

func rollEntity(entity: String, check:String) -> bool:
	return await roll(entities[entity].checks[check])

func roll(check: CheckRes) -> bool:

	# Handle devtools
	if get_tree().root.has_node("DiscoDevtools"):

		var disco_dev_tools: Variant = get_tree().root.get_node("DiscoDevtools")
		var checkState: Variant = disco_dev_tools.get("DEV_force_check_state")

		# Checking OFF
		if checkState == 0:
			rollResult = await _rollLogic(check)

		# Checking SUCCESS
		if checkState == 1:
			rollResult = true

		# Checking FAIL 
		if checkState == 2:
			rollResult = false
	else: 
		# Devtools not enabled, roll as normal.
		rollResult = await _rollLogic(check)

	return rollResult

func _rollLogic(check: CheckRes) -> bool:
	var result: bool = false
	
	# Create new handler if none currently exist
	if currentHandler == null:
		var roller: RollHandler = state.rollHandler.instantiate()
		currentHandler = roller;
		var root: Viewport = get_tree().root
		root.get_child(-1).add_child(roller)

	currentHandler.show()
	result = await currentHandler.rollCheck(check)
	currentHandler.hide()

	return result

func rollOddsPlayer(check:String) -> int:
	return Disco.getRollOdds(playerChecks[check])

func rollOddsEntity(entity: String, check:String) -> int:
	return Disco.getRollOdds(entities[entity].checks[check])

func getRollOdds(check: CheckRes) -> int:
	return Disco.state.handlerScript.getRollOdds(check)

# ENUMS

enum EEventStatus { NOT_OFFERED, SUCCESS, FAILURE, OTHER }

enum EMissionStatus { NOT_OFFERED, IN_PROGRESS, SUCCESS, FAILURE, DENIED, OTHER }
