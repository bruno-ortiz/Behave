tool

extends GraphNode

var node_model = null setget set_model,get_model

func set_model(model):
	node_model = weakref(model)

func get_model():
	return node_model.get_ref()