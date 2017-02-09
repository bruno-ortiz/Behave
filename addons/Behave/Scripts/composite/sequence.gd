extends "res://addons/Behave/Scripts/composite/composite.gd"

var current_child_idx = -1
var active_child = null

func on_enter(context):
	current_child_idx = 0
	active_child = children[current_child_idx]
	active_child.on_enter(context)

func tick(context):
	var current_status = active_child.status
	if current_status == Status.FAILURE or current_status == Status.TERMINATED:
		return Status.FAILURE
	elif current_status == Status.RUNNING:
		return Status.RUNNING
	current_child_idx += 1
	if current_child_idx < children.size():
		active_child = children[current_child_idx]
		active_child.on_enter(context)
		return Status.RUNNING
	return current_status
