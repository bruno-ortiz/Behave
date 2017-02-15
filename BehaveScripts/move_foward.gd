extends "res://addons/Behave/Scripts/action/action_task.gd"

var ticked = 0

func tick(context):
	ticked = ticked +1
	print(ticked)
	var target = context.target
	target.move(Vector2(50, 0) * context.delta)
	return Status.SUCCESS
