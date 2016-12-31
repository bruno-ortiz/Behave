tool

extends GraphNode

var utils = preload("res://addons/Behave/Editor/Scripts/utils.gd")
var _node_model_type = preload("res://addons/Behave/Scripts/composite/sequence.gd")

var node_model = null

func _enter_tree():
	node_model = utils.create_new_behavior_node("Sequence", _node_model_type, null)
