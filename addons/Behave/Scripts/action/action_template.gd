extends "res://addons/Behave/Scripts/action/action_task.gd"


func on_enter(context):
	.on_enter(context)

func do_tick(context):
	return Status.RUNNING

func on_exit(context):
	.on_exit(context)