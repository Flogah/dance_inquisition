extends Area3D
#TODO: add raycast

var interactablesInRange: Array[Node3D]

func start() -> Node3D:
	interactablesInRange = scanInteractables()
	return findNearestInteractable()

func _on_body_exited(body: Node3D) -> void:
	if DiscoUtils.isInteractable(body):
		if (interactablesInRange.has(body)):
			interactablesInRange.erase(body)
		else:
			interactablesInRange = scanInteractables()
		get_parent().get_parent().interactionTarget = findNearestInteractable()

func _on_body_entered(body: Node3D) -> void:
	if DiscoUtils.isInteractable(body):
		if (!interactablesInRange.has(body)):
			interactablesInRange.append(body)
		else:
			interactablesInRange = scanInteractables()
		get_parent().get_parent().interactionTarget = findNearestInteractable()

func scanInteractables() -> Array[Node3D]:
	var interactables:Array[Node3D] = []
	var bodiesInRange = get_overlapping_bodies()

	for body in bodiesInRange:
		if DiscoUtils.isInteractable(body):
			interactables.append(body)

	return interactables

func findNearestInteractable() -> Node3D:
	if interactablesInRange.size() == 1:
		return interactablesInRange[0]
	elif interactablesInRange.size() > 1:
		var closest: Node3D = null
		var distance: float = 0
		for body in interactablesInRange:
			var bodyPos: Vector3 = body.global_position
			var bodyDist = %Collider.global_position.distance_to(bodyPos)
			if (closest == null):
				closest = body
				distance = bodyDist
			elif bodyDist <= distance:
				closest = body
				distance = bodyDist
		return closest
	else:
		return null
	
