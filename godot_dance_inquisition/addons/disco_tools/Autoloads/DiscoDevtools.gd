# NOTE: Attempting to disable this autoload will not have any effect. 
# To disable its functionality, one must completely remove it as an autoload.
# Disco tools will function perfectly fine without it.

@icon("res://addons/disco_tools/Assets/disco.svg")
extends Node

enum DEV_force_checks {OFF,SUCCESS,FAIL}

@export var DEV_force_check_state: DEV_force_checks


