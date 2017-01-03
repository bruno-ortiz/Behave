tool

extends "res://addons/Behave/Editor/Scripts/base_behavior_node_view.gd"

var _node_model_type = preload("res://addons/Behave/Scripts/composite/selector.gd")

func get_model_type():
	return _node_model_type

func get_behavior_name():
	return "Selector"