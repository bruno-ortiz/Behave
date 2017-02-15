extends "res://addons/Behave/Scripts/action/action_task.gd"


func on_enter(context):
	.on_enter(context)

func tick(context):
	var target = context.target
	target.move(Vector2(0, 50) * context.delta)
	if target.get_pos().y > 600:
		return Status.FAILURE
	return Status.RUNNING

func on_exit(context):
	.on_exit(context)