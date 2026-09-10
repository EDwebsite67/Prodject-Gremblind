extends CharacterBody3D


const SPEED = 100.0
const JUMP_VELOCITY = 20.5


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		$Gremblind/AnimationPlayer.play("ArmatureAction")
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
		$Gremblind/AnimationPlayer.stop()
	
	if Input.is_action_pressed("left"):
		rotation.y = 270
	
	if Input.is_action_pressed("right"):
		rotation.y = 90
	
	if Input.is_action_pressed("up"):
		rotation.y = 0
	
	if Input.is_action_pressed("down"):
		rotation.y = 180

	move_and_slide()
