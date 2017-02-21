
extends Node

signal select_node(node)

var Status = preload("res://addons/Behave/Scripts/utils/status.gd")

var child = null

var first_tick = true

var interruptors = {}

var context = {
	tree = self
}

func start_behave(kwargs = null):
	if kwargs:
		for k in kwargs:
			context[k] = kwargs[k]
	child = get_child(0)
	set_process(true)

func _process(delta):
	context["delta"] = delta
	context["target"] = get_parent()
	if first_tick:
		child.on_enter(context)
		first_tick = false
	else:
		var tree_status = child.tick(context)
		if tree_status != Status.RUNNING:
			set_process(false)



func register_interruptor(interruptor_id, interruptor):
	interruptors[interruptor_id] = interruptor

func unregister_interruptor(interruptor_id):
	interruptors.erase(interruptor_id)
	
func get_interruptor(interruptor_id):
	if interruptors.has(interruptor_id):
		return interruptors[interruptor_id]
	return null