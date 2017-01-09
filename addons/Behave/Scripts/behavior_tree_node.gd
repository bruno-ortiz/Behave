extends Node2D
var Status = preload("res://addons/Behave/Scripts/utils/status.gd")

var position = 0
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