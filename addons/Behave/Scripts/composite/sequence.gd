tool

extends "res://addons/Behave/Scripts/composite/composite.gd"

var editor_view = preload("res://addons/Behave/Editor/Scenes/Composite/SequenceNode.tscn")
var current_child = 0

func _init(params=null):
	pass

func tick(context):
	pass


func create_view():
	var view = editor_view.instance()
	view.set_offset(get_pos())
	view.node_model = self
	return view