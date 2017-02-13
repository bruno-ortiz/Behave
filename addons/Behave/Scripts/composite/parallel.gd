extends "res://addons/Behave/Scripts/composite/composite.gd"



func on_enter(context):
	.on_enter(context)
	for child in children:
		child.on_enter(context)
	
func tick(context):
	var one_running = false
	for child in children:
		var current_status = child.status
		if current_status == Status.RUNNING:
			one_running = true
		elif current_status == Status.FAILURE or current_status == Status.TERMINATED:
			_terminate_all(context)
			return Status.FAILURE
	if not one_running:
		return Status.SUCCESS
	else:
		return Status.RUNNING
	

func _terminate_all(context):
	for c in children:
		c.on_exit(context)
