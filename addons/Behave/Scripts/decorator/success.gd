extends "res://addons/Behave/Scripts/decorator/decorator.gd"


func do_tick(context):
	var new_status = child.tick(context)
	if new_status == Status.RUNNING:
		return Status.RUNNING
	return Status.SUCCESS