extends Area2D
class_name InteractionArea2D

var interactablesInRange: Array[Node2D]

func start() -> Node2D:
	interactablesInRange = scanInteractables()
	return findNearestInteractable()

func _on_body_exited(body: Node2D):
	if Disco.isInteractable(body):
		if (interactablesInRange.has(body)):
			interactablesInRange.erase(body)
		else:
			interactablesInRange = scanInteractables()

func _on_body_entered(body: Node2D):
	if Disco.isInteractable(body):
		if (!interactablesInRange.has(body)):
			interactablesInRange.append(body)
		else:
			interactablesInRange = scanInteractables()

func scanInteractables() -> Array[Node2D]:
	var interactables:Array[Node2D] = []
	var bodiesInRange = get_overlapping_bodies()

	for body in bodiesInRange:
		if Disco.isInteractable(body):
			interactables.append(body)

	return interactables

func findNearestInteractable() -> Node2D:
	if interactablesInRange.size() == 1:
		return interactablesInRange[0]
	elif interactablesInRange.size() > 1:
		var closest: Node2D = null
		var distance: float = 0
		for body in interactablesInRange:
			var bodyPos: Vector2 = body.global_position
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
	
