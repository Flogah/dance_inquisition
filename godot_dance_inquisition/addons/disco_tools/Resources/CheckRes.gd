@icon("res://addons/disco_tools/Assets/disco.svg")
@tool
@abstract
extends DiscoRes
class_name CheckRes
# Base check class. Must be extended to make a custom check

@abstract func to_bool() -> bool
