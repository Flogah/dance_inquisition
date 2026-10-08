extends Area3D
class_name InteractionArea

var interactables: Array[InteractableArea]
var active: InteractableArea

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("interact"):
		interact()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if interactables.size() > 1:
		var closest: InteractableArea = interactables[0]
		var closest_distance: float = closest.global_position.distance_to(global_position)
		for area in interactables:
			if area.global_position.distance_to(global_position) < closest_distance:
				closest = area
		active = closest

func interact():
	if active is InteractableArea:
		active.interact()

func _on_area_entered(area: Area3D) -> void:
	if area is InteractableArea:
		interactables.append(area)
		if active == null:
			active = area

func _on_area_exited(area: Area3D) -> void:
	if area is InteractableArea:
		interactables.erase(area)
		if area == active:
			active = null
