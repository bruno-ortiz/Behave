tool

extends "res://addons/Behave/Scripts/composite/composite.gd"


var editor_view = preload("res://addons/Behave/Editor/Scenes/Composite/SequenceNode.tscn")
var current_child_idx = -1
var children = null
var active_child = null

func _init(params=null):
	pass

func on_enter(context):
	current_child_idx = 0
	children = get_children()
	active_child = children[current_child_idx]
	active_child.on_enter(context)

func create_view():
  var view = editor_view.instance()
  view.set_offset(get_pos())
  view.node_model = self
  return view
