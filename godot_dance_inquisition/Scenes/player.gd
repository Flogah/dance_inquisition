extends CharacterBody3D

@onready var dialogue_system: CanvasLayer = %DialogueSystem
@onready var interaction_area: InteractionArea = %InteractionArea

const SPEED = 5.0

func _ready() -> void:
	interaction_area.interacted_with_npc.connect(start_talking)

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var direction := (transform.basis.rotated(Vector3.UP, 0.35) * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("find_the_book"):
		find_book()

func start_talking(npc):
	dialogue_system.start_dialog()

func find_book():
	SproutyDialogs.Variables.set_variable("has_book", true)
