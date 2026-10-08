@icon("res://addons/disco_tools/Assets/disco.svg")
@tool
extends EditorPlugin

const AUTOLOAD_NAME = "Disco"
const AUTOLOAD_NAME_3 = "DiscoUtils"
const AUTOLOAD_NAME_2 = "DiscoDevtools"

func _enter_tree():
	# Initialization of the plugin goes here.
	add_autoload_singleton(AUTOLOAD_NAME, "res://addons/disco_tools/Autoloads/disco_tools.tscn")
	add_autoload_singleton(AUTOLOAD_NAME_2, "res://addons/disco_tools/Autoloads/DiscoDevtools.gd")
	add_autoload_singleton(AUTOLOAD_NAME_3, "res://addons/disco_tools/Autoloads/DiscoUtils.gd")


func _exit_tree():
	# Clean-up of the plugin goes here.
	remove_autoload_singleton(AUTOLOAD_NAME)
	remove_autoload_singleton(AUTOLOAD_NAME_2)
	remove_autoload_singleton(AUTOLOAD_NAME_3)
