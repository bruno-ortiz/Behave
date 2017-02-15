extends "res://addons/Behave/Scripts/decorator/decorator.gd"


func tick(context):
	var new_status = child.tick(context)
	if new_status == Status.FAILURE or new_status == Status.TERMINATED:
		return Status.SUCCESS
	elif new_status == Status.SUCCESS:
		child.on_enter(context)
	return Status.RUNNING