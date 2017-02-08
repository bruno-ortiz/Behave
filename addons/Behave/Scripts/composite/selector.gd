tool

extends "res://addons/Behave/Scripts/composite/composite.gd"

var current_child = 0

func tick(context):
	status = active_child.status
	if status == Status.FAILURE or status == Status.TERMINATED:
		current_child_idx += 1
		if current_child_idx < children.size():
			active_child = children[current_child_idx]
			active_child.on_enter(context)
	return status