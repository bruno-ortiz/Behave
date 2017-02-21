extends "res://addons/Behave/Scripts/action/action_task.gd"

export(String) var interrupt_id = null

func on_enter(context):
	.on_enter(context)

func do_tick(context):
	var interruptor = context.tree.get_interruptor(interrupt_id)
	if interruptor:
		interruptor.interrupt(context)
		context.tree.unregister_interruptor(interrupt_id)
	return Status.SUCCESS

func on_exit(context):
	.on_exit(context)