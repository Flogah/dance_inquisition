extends Area3D
class_name InteractableArea

signal interacted

func interact():
	interacted.emit()
