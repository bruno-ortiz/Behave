extends Node

var Status = preload("res://addons/Behave/Scripts/utils/status.gd")
var status = Status.NOT_STARTED
var terminated = false

func on_enter(context):
	status = Status.RUNNING
	terminated = false

func tick(context):
	if not terminated:
		var new_status = do_tick(context)
		if new_status != Status.RUNNING:
			status = new_status
	else:
		status = Status.TERMINATED
	return status

func on_exit(context):
	status = Status.TERMINATED
	terminated = true