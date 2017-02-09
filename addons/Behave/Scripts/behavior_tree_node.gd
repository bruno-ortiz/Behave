extends Node

var Status = preload("res://addons/Behave/Scripts/utils/status.gd")
var status = Status.NOT_STARTED

func on_enter(context):
	status = Status.RUNNING
	context.tree.tickable_tasks.append(self)

func tick(context):
	pass

func on_exit(context):
	status = Status.TERMINATED
	context.tree.tickable_tasks.erase(self)