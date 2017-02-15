extends "res://addons/Behave/Scripts/action/action_task.gd"

var ticked = 0


func on_enter(context):
	.on_enter(context)


func tick(context):
	ticked = ticked +1
	print(ticked)
	var target = context.target
	target.move(Vector2(50, 0) * context.delta)
	return Status.RUNNING


func on_exit(context):
	.on_exit(context)