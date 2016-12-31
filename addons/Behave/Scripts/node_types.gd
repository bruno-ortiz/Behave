tool

extends Node

var NODE_TYPES = {
	"Sequence": load("res://addons/Behave/Scripts/composite/sequence.gd"),
	"Selector": load("res://addons/Behave/Scripts/composite/selector.gd")
}

var utils = preload("res://addons/Behave/Editor/Scripts/utils.gd").new()

func create_new_node(type, params):
	var node_type = NODE_TYPES[type]
	var new_node = node_type.new(params)
	new_node.node_id = _create_node_id()
	new_node.set_name(type)
	return new_node
	
func _create_node_id():
	return OS.get_ticks_msec()