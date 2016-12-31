extends Node

var Status = preload("res://addons/Behave/Scripts/utils/status.gd")

var status = Status.RUNNING
var node_id = -1

func _enter_tree():
	node_id = OS.get_ticks_msec()
	
func on_enter(context):
	pass

func tick(context):
	pass

func on_exit(context):
	pass