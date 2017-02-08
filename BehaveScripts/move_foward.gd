extends "res://addons/Behave/Scripts/action/action_task.gd"



func tick(context):
	var target = context.target
	target.move(Vector2(50, 0) * context.delta)
	if target.get_pos().x > 200:
		return Status.SUCCESS
	return Status.RUNNING
