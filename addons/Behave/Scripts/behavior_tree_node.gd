extends Node

var Status = preload("res://addons/Behave/Scripts/utils/status.gd")
var status = Status.NOT_STARTED
var terminated = false

func on_enter(context):
	status = Status.RUNNING
	context.tree.insertion_requests.append(self)

func tick(context):
	pass

func on_exit(context):
	status = Status.TERMINATED
	context.tree.removal_requests.append(self)
	terminated = true