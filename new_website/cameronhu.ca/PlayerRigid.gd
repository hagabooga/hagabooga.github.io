extends RigidBody2D


enum {IDLE, RUN, AIR}
var state_strings := {
	IDLE: "idle",
	RUN: "run",
	AIR: "air"
}

onready var on_air_timer : Timer = $OnAirTimer
onready var transitions := {
	IDLE: [RUN, AIR],
	RUN: [IDLE, AIR],
	AIR: [IDLE]
}

const RUN_SPEED := 400
const AIR_SPEED := 3
const JUMP_FORCE := 4000

var _state := IDLE

func _ready():
	Engine.set_target_fps(Engine.get_iterations_per_second())

func _integrate_forces(state : Physics2DDirectBodyState):
	var is_on_ground := state.get_contact_count() > 0 and \
		int(state.get_contact_collider_position(0).y) >= int(global_position.y)
	var move_direction := get_move_direction()
	match _state:
		IDLE:
			if move_direction.x != 0:
				change_state(RUN)
			elif is_on_ground and Input.is_action_just_pressed("ui_select"):
				apply_central_impulse(Vector2.UP * JUMP_FORCE)
				change_state(AIR)
			elif move_direction.x == 0 and abs(state.linear_velocity.x) != 0:
				if 0 <= abs(state.linear_velocity.x) and abs(state.linear_velocity.x) <= 20:
					state.linear_velocity.x = 0
				else:
					apply_central_impulse(400 * (Vector2.RIGHT if state.linear_velocity.x < 0 else Vector2.LEFT))
		
		RUN:
			if move_direction.x == 0:
				change_state(IDLE)
			elif state.get_contact_count() == 0:
				change_state(AIR)
			elif is_on_ground and Input.is_action_just_pressed("ui_select"):
				apply_central_impulse(Vector2.UP * JUMP_FORCE)
				change_state(AIR)
			else:  
				apply_central_impulse(move_direction * 600)

				if abs(state.linear_velocity.x) > RUN_SPEED:
					state.linear_velocity.x = RUN_SPEED * (-1 if state.linear_velocity.x <  0 else 1)
#				state.linear_velocity.x = move_direction.x * RUN_SPEED
		
		AIR:
			if move_direction.x != 0:
				apply_central_impulse(move_direction * 50)
				if abs(state.linear_velocity.x) > 400:
					state.linear_velocity.x = 400 * (-1 if state.linear_velocity.x < 0 else 1)
#				state.linear_velocity.x += move_direction.x * AIR_SPEED
			if is_on_ground and on_air_timer.is_stopped():
				change_state(IDLE)
#	print(move_direction)
	print(state.linear_velocity.x)
#	print(_state)

func change_state(target_state : int) -> void:
	if not target_state in transitions[_state]:
		return
	_state = target_state
	enter_state()
	

func enter_state() -> void:
	match _state:
		IDLE:
			pass
#			linear_velocity.x = 0
		AIR:
			on_air_timer.start()
		_:
			return


static func get_move_direction() -> Vector2:
	return Vector2(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"), 0
	)
				
				
				
				
				
				
				
				
				
				
				
				
				
	
