extends "res://addons/Behave/Scripts/decorator/decorator.gd"

export(String) var interrupt_id = null

var interrupted = false

func on_enter(context):
	.on_enter(context)
	assert(not interrupt_id == null or not interrupt_id == "")
	context.tree.register_interruptor(interrupt_id, self)


func do_tick(context):
	if not interrupted:
		var new_status = child.tick(context)
		if new_status != Status.RUNNING:
			context.tree.unregister_interruptor(interrupt_id)
		return new_status
	return status
	

func interrupt(context):
	if not terminated:
		on_exit(context)
		interrupted = true
		status = Status.SUCCESS