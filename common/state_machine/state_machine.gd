extends Node
class_name StateMachine
var current_state : State
var states : Dictionary = {}

@export var initial_state : State
@export var debug_label : Label

func _ready():
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.transitioned.connect(_on_child_transition)
			
	if initial_state:
		initial_state.enter()
		current_state = initial_state
	
func _process(delta):
	if debug_label : 
		debug_label.text = current_state.name
	if current_state:
		current_state.update(delta)

func _physics_process(delta):
	if current_state:
		current_state.physics_update(delta)

func _on_child_transition(state, new_state_name : String):
	if state != current_state:
		return
		
	var new_state : State = states.get(new_state_name.to_lower())
	if !new_state:
		return
	
	if current_state:
		current_state.exit()
	
	new_state.enter()
	current_state = new_state

#force state machine to transition from any state to new_state
func force_state_change(new_state : String):
	current_state.transitioned.emit(current_state, new_state)
