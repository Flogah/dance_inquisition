extends CharacterBody2D 
class_name Entity

@export var EntityName: String

var npcRes: EntityRes

# TODO: get prompt from some disco tools var
@export var prompt: String = "";

func _ready():
	npcRes = Disco.entities[EntityName]
	if (prompt == ""):
		prompt = "Talk to ";
	

func getPrompt():
	return prompt + " " + npcRes.name

func interact():
	
		DialogueManager.show_dialogue_balloon(npcRes.mainDialogue, "start");

func canInteract():
	return true
