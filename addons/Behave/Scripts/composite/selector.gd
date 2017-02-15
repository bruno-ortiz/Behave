extends "res://addons/Behave/Scripts/composite/composite.gd"

var current_child_idx = -1
var active_child = null

func on_enter(context):
	.on_enter(context)
	current_child_idx = 0
	active_child = children[current_child_idx]
	active_child.on_enter(context)

func do_tick(context):
	var new_status = active_child.tick(context)
	if new_status == Status.FAILURE or new_status == Status.TERMINATED:
		current_child_idx += 1
		if current_child_idx < children.size():
			active_child = children[current_child_idx]
			active_child.on_enter(context)
			return Status.RUNNING
	return new_status